class TweetsController < ApplicationController
  def list
    render json: Tweet.all, except: [:user_id], include: {
      user: {
        except: [:password_digest, :created_at, :updated_at]
      }
    }
  end
end
