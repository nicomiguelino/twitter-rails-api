# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

def initialize_users
  users = [
    {
      username: 'mike.wheeler',
      email: 'mike.wheeler@hawkins.com',
      password: 'eleven'
    },
    {
      username: 'will.byers',
      email: 'will.byers@hawkins.com',
      password: 'will_the_wise'
    },
    {
      username: 'dustin.henderson',
      email: 'dustin.henderson@hawkins.com',
      password: 'pearly_whites'
    }
  ]

  users.each do |user|
    User.create(**user)
  end

  return User.all
end

def initialize_tweets(users)
  tweets = [
    {
      content: 'My first ever post.',
      user_id: users[0].id
    },
    {
      content: 'Another one bites the dust.',
      user_id: users[1].id
    },
    {
      content: 'Third time\'s a charm!',
      user_id: users[2].id
    }
  ]

  tweets.each do |tweet|
    Tweet.create(**tweet)
  end

  return Tweet.all
end

users = initialize_users
initialize_tweets(users)
