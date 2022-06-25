module Types
  class MutationType < Types::BaseObject
    field :create_tweet, TweetType, 'Create a Tweet', null: false  do
      argument :content, String
    end

    field :update_tweet, TweetType, 'Update a Tweet', null: false do
      argument :id, ID
      argument :content, String
    end

    field :delete_tweet, TweetType, 'Delete a Tweet', null: false do
      argument :id, ID
    end

    def create_tweet(content:)
      authorize
      user = context[:current_user]
      user.tweets.create(content: content)
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
