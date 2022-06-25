module Types
  class MutationType < Types::BaseObject
    field :create_tweet, resolver: Resolvers::Tweets::CreateResolver
    field :update_tweet, resolver: Resolvers::Tweets::UpdateResolver
    field :delete_tweet, resolver: Resolvers::Tweets::DeleteResolver
  end
end
