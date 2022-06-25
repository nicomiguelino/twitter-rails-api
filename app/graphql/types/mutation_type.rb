module Types
  class MutationType < Types::BaseObject
    field :create_tweet, resolver: Resolvers::Tweets::CreateResolver

    field :update_tweet, TweetType, 'Update a Tweet', null: false do
      argument :id, ID
      argument :content, String
    end

    field :delete_tweet, TweetType, 'Delete a Tweet', null: false do
      argument :id, ID
    end

    def update_tweet(id:, content:)
      authorize

      begin
        tweet = Tweet.find(id)
        tweet.update(content: content)
      rescue StandardError => e
        raise GraphQL::ExecutionError.new(
          e.message, extensions: { status: 400 }
        )
      end

      return tweet
    end

    def delete_tweet(id:)
      authorize

      begin
        tweet = Tweet.find(id)
        tweet.destroy
      rescue StandardError => e
        raise GraphQL::ExecutionError.new(
          e.message, extensions: { status: 400 }
        )
      end

      return tweet
    end
  end
end
