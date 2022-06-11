# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

def initialize_tweets
  tweets = [
    {
      content: 'My first ever post.'
    },
    {
      content: 'Another one bites the dust.'
    },
    {
      content: 'Third time\'s a charm!'
    }
  ]

  tweets.each do |tweet|
    Tweet.create(**tweet)
  end
end

initialize_tweets
