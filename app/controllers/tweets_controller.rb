class TweetsController < ApplicationController
  def list
    render json: Tweet.all, except: [:user_id], include: {
      user: {
        except: [:password_digest, :created_at, :updated_at]
      }
    }
  end

  def create
    # TODO: Make the user dynamic.
    user = User.where(username: 'dustin.henderson').first
    tweet = user.tweets.create(**tweets_create_params)
    render json: tweet
  end

  private

  def tweets_create_params
    params.require(:tweet).permit(:content)
  end
end
