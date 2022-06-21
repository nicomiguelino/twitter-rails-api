class API::TweetsController < ApplicationController
  before_action :authorize_request

  def index
    render json: Tweet.all, except: [:user_id], include: {
      user: {
        except: [:password_digest, :created_at, :updated_at]
      }
    }
  end

  def create
    tweet = @current_user.tweets.create(**tweets_create_params)
    render json: tweet
  end

  private

  def tweets_create_params
    params.require(:tweet).permit(:content)
  end
end
