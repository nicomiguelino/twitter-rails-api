module Resolvers::Tweets
  class ListResolver < Resolvers::BaseResolver
    include Mixins::Authorization

    description 'Get all Tweets'
    type [Types::TweetType], null: false

    def resolve
      Tweet.all
    end
  end

  class DetailResolver < Resolvers::BaseResolver
    include Mixins::Authorization

    description 'Find a Tweet by ID'
    type Types::TweetType, null: false

    argument :id, ID

    def resolve(id:)
      # TODO: Refactor into a module, e.g. mixins/authorization.
      begin
        Tweet.find(id)
      rescue StandardError => e
        raise GraphQL::ExecutionError.new(
          e.message, extensions: { status: 400 }
        )
      end
    end
  end
end
