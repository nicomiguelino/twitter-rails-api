module Mixins::Tweets
  extend ActiveSupport::Concern

  included do
    def get_tweet_by_id(id)
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
