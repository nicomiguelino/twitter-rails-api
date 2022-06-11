# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

def initialize_tweets
  users = [
    {
      username: 'mike.wheeler',
      email: 'mike.wheeler@hawkins.com',
      password: 'eleven',
      tweets: [
        {
          content: 'My first post.'
        },
        {
          content: 'Another one.'
        }
      ]
    },
    {
      username: 'will.byers',
      email: 'will.byers@hawkins.com',
      password: 'will_the_wise',
    },
    {
      username: 'dustin.henderson',
      email: 'dustin.henderson@hawkins.com',
      password: 'pearly_whites',
      tweets: [
        {
          content: 'Lucas, do you copy?!'
        }
      ]
    }
  ]

  users.each do |user|
    new_user = User.create(**user.except(:tweets))

    if user.has_key? :tweets
      user[:tweets].each do |tweet|
        new_user.tweets.create(**tweet)
      end
    end
  end
end

initialize_tweets
