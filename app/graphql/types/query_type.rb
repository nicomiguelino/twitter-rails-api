module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :tweets, resolver: Resolvers::Tweets::ListResolver
    field :tweet, resolver: Resolvers::Tweets::DetailResolver

    field :users, resolver: Resolvers::Users::ListResolver
    field :user, resolver: Resolvers::Users::DetailResolver
  end
end
