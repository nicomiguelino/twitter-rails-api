module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :tweets, resolver: Resolvers::Tweets::ListResolver
    field :tweet, TweetType, 'Find a Tweet by ID' do
      argument :id, ID
    end

    field :users, [UserType], 'Get all the registered users', null: false
    field :user, UserType, 'Find a User by ID', null: false do
      argument :id, ID
    end

    def tweet(id:)
      authorize
      Tweet.find(id)
    end

    def users
      authorize
      User.all
    end

    def user(id:)
      authorize
      User.find(id)
    end
  end
end
