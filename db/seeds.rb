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
      name: 'Mike Wheeler',
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
      name: 'Will Byers',
      username: 'will.byers',
      email: 'will.byers@hawkins.com',
      password: 'will_the_wise',
    },
    {
      name: 'Dustin Henderson',
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

def initialize_comments
  users_hash = {
    mike: User.find_by_username('mike.wheeler'),
    will: User.find_by_username('will.byers'),
    dustin: User.find_by_username('dustin.henderson')
  }

  tweets = Tweet.all

  tweets[0].comments.create(
    content: 'First comment!',
    user: users_hash[:mike]
  )
  tweets[1].comments.create(
    content: 'Another one!',
    user: users_hash[:will]
  )
  tweets[2].comments.create(
    content: 'Third time\'s a charm!',
    user: users_hash[:dustin]
  )
end

initialize_tweets
initialize_comments
