class TweetsController < ApplicationController
  def list
    render json: Tweet.all
  end
end
