module Resolvers::Authentication
  class LoginResolver < Resolvers::BaseResolver
    description 'Simple login using email and password'
    type Types::UserType, null: false

    argument :email, String
    argument :password, String

    def resolve(email:, password:)
      user = User.find_by_email(email)

      if user&.authenticate(password)
        token = Core::JSONWebToken.encode(user_id: user.id)
        cookies = context[:cookies]
        cookies.signed[:token] = {
          value: token,
          httponly: true
        }

        return user
      else
        raise GraphQL::ExecutionError.new(
          'Login failed. Incorrect credentials.',
          extensions: { status: 401 }
        )
      end
    end
  end
end
