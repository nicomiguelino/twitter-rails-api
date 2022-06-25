module Resolvers::Tweets
  class ListResolver < Resolvers::BaseResolver
    description 'Get all Tweets'
    type [Types::TweetType], null: false

    # TODO: Make this method reusable on other resolvers.
    def authorized?
      return !context[:current_user].nil?
    end

    def resolve
      Tweet.all
    end
  end
end
