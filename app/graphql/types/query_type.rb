module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :tweets, [TweetType], 'Get all Tweets', null: false
    field :tweet, TweetType, 'Find a Tweet by ID' do
      argument :id, ID
    end

    field :users, [UserType], 'Get all the registered users', null: false
    field :user, UserType, 'Find a User by ID', null: false do
      argument :id, ID
    end

    def tweets
      Tweet.all
    end

    def tweet(id:)
      Tweet.find(id)
    end

    def users
      User.all
    end

    def user(id:)
      User.find(id)
    end
  end
end
