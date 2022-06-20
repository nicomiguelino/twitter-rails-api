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

      get api_tweets_list_path
      expect(response.status).to eq(200)
    end

    it 'returns an error', :skip_login do
      get api_tweets_list_path
      expect(response.status).to eq(401)
    end
  end

  describe 'POST /api/tweets' do
    it 'creates a Tweet' do
      post api_tweets_create_path, params: {
        tweet: {
          content: 'Yet another Tweet...'
        }
      }, as: :json
      expect(response.status).to eq(200)
    end
  end
end
