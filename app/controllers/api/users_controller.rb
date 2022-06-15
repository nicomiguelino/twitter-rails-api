class API::UsersController < ApplicationController
  before_action :authorize_request

  def list
    render json: User.all, except: [:password_digest], include: {
      tweets: {
        except: [:user_id]
      }
    }
  end
end