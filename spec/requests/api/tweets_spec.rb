require 'rails_helper'

RSpec.describe "API::Tweets", type: :request do
  describe 'GET /api/tweets' do
    it 'returns a list of Tweets' do
      tweets = [
        'My first tweet. Welcome to Twitter.',
        'Anothah one.',
        'Third time\'s a charm.'
      ]

      tweets.each do |tweet|
        @user.tweets.create content: tweet
      end

      get api_tweets_path
      expect(response.status).to eq(200)
    end

    it 'returns an error', :skip_login do
      get api_tweets_path
      expect(response.status).to eq(401)
    end
  end

  describe 'POST /api/tweets' do
    def tweet_params
      {
        tweet: {
          content: 'Yet another Tweet...'
        }
      }
    end

    it 'creates a Tweet' do
      post api_tweets_path, params: tweet_params, as: :json
      expect(response.status).to eq(200)
    end

    it 'returns an error message if unauthorized', :skip_login do
      post api_tweets_path, params: tweet_params, as: :json
      expect(response.status).to eq(401)
    end
  end

  describe 'GET /api/tweets/:id' do
    before :each do
      @tweet = @user.tweets.create(content: 'Another one bites the dust!')
    end

    it 'returns the details of a Tweet' do
      get api_tweet_path(id: @tweet.id)
      expect(response.status).to eq(200)
    end

    it 'returns an error on invalid Tweet ID', :skip_login do
      tweet = @user.tweets.create(content: 'Another one bites the dust!')
      get api_tweet_path(id: @tweet.id)
      expect(response.status).to eq(401)
    end
  end
end
