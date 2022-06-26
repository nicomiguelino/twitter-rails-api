module Resolvers::Tweets
  module HasCreatedTweet
    include Mixins::Authorization
    include Mixins::Tweets

    def authorized?(object = nil, args = nil, ctx = nil)
      if !object&.include?(:id)
        return false
      end

      tweet = get_tweet_by_id(object[:id])
      user = context[:current_user]

      return is_logged_in && user.id == tweet.user_id
    end
  end

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

  class UpdateResolver < Resolvers::BaseResolver
    include HasCreatedTweet

    description 'Update a Tweet'
    type Types::TweetType, null: false

    argument :id, ID
    argument :content, String

    def resolve(id:, content:)
      tweet = get_tweet_by_id(id)
      tweet.update(content: content)
      return tweet
    end
  end

  class DeleteResolver < Resolvers::BaseResolver
    include HasCreatedTweet

    description 'Delete a Tweet'
    type Types::TweetType, null: false
    argument :id, ID

    def resolve(id:)
      get_tweet_by_id(id).destroy
    end
  end
end
