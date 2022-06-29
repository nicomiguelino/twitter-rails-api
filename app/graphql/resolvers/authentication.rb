module Resolvers::Authentication
  class LoginResolver < Resolvers::BaseResolver
    description 'Simple login using email and password'
    type Types::UserType, null: false

    argument :email, String
    argument :password, String

    def resolve(email:, password:)
      user = User.find_by_email(email)

      if user&.authenticate(password)
        unless context[:cookies].signed[:token].nil?
          raise GraphQL::ExecutionError.new(
            'Already logged in.',
            extensions: {
              status: 400,
              username: user.username,
              email: user.email
            }
          )
        end

        token = Core::JSONWebToken.encode(user_id: user.id)
        context[:cookies].signed[:token] = {
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

  class LogoutResolver < Resolvers::BaseResolver
    description 'Log out and remove relevant cookies'
    type Types::BasicSuccessMessageType, null: true

    def resolve
      if !context[:cookies].signed[:token]
        raise GraphQL::ExecutionError.new(
          'Can\'t log out.', extensions: { status: 400 }
        )
      end

      begin
        context[:cookies].delete :token
      rescue StandardError => e
        raise GraphQL::ExecutionError.new(
          e.message, extensions: { status: 400 }
        )
      else
        { message: 'Logged out successfully.' }
      end
    end
  end
end
