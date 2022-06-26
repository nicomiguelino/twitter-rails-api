module Resolvers::Users
  class ListResolver < Resolvers::BaseResolver
    include Mixins::Authorization

    description 'Get all registered users.'
    type [Types::UserType], null: false

    def resolve
      User.all
    end
  end
end
