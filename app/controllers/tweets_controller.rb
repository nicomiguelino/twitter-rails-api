class TweetsController < ApplicationController
  def list
    render json: Tweet.all, methods: [:user], except: [:user_id]
  end
end
