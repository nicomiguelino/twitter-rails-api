module Resolvers::Tweets
  class ListResolver < Resolvers::BaseResolver
    include Mixins::Authorization

    description 'Get all Tweets'
    type [Types::TweetType], null: false

    def resolve
      Tweet.all
    end
  end
end
