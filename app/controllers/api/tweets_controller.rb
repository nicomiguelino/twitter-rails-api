class API::TweetsController < ApplicationController
  before_action :authorize_request

  def index
    render json: Tweet.all,
      except: [:user_id],
      methods: [:url],
      include: {
        user: {
          except: [:password_digest, :created_at, :updated_at]
        }
      }
  end

  def create
    tweet = @current_user.tweets.create(**tweet_params)
    render json: tweet
  end

  def show
    begin
      tweet = Tweet.find(params[:id])
      render render_args(tweet)
    rescue StandardError => e
      render json: { error: e.message }, status: :bad_request
    end
  end

  def destroy
    begin
      tweet = Tweet.find(params[:id]).destroy
      render render_args(tweet)
    rescue StandardError => e
      render json: { error: e.message }, status: :bad_request
    end
  end

  def update
    begin
      tweet = Tweet.find(params[:id])
      tweet.update(**tweet_params)
      render render_args(tweet)
    rescue StandardError => e
      render json: { error: e.message }, status: :bad_request
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:content)
  end

  def render_args(tweet, status: :ok)
    {
      json: tweet,
      except: [:user_id], include: {
        user: {
          except: [:password_digest, :created_at, :updated_at]
        }
      }
    }
  end
end
