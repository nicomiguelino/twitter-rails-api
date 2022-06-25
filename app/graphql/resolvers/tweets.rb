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
    include Mixins::Tweets

    description 'Find a Tweet by ID'
    type Types::TweetType, null: false

    argument :id, ID

    def resolve(id:)
      return get_tweet_by_id(id)
    end
  end

  class CreateResolver < Resolvers::BaseResolver
    include Mixins::Authorization

    description 'Create a Tweet'
    type Types::TweetType, null: false

    argument :content, String

    def resolve(content:)
      context[:current_user].tweets.create(content: content)
    end
  end
end
