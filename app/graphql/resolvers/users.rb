module Resolvers::Users
  class ListResolver < Resolvers::BaseResolver
    include Mixins::Authorization

    description 'Get all registered users'
    type [Types::UserType], null: false

    def resolve
      User.all
    end
  end

  class DetailResolver < Resolvers::BaseResolver
    include Mixins::Authorization
    include Mixins::Users

    description 'Find a user by ID'
    type Types::UserType, null: false
    argument :id, ID

    def resolve(id:)
      get_user_by_id(id)
    end
  end
end
