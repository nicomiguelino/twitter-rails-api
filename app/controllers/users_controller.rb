class UsersController < ApplicationController
  def list
    render json: User.all, except: [:password_digest], include: {
      tweets: {
        except: [:user_id]
      }
    }
  end
end
