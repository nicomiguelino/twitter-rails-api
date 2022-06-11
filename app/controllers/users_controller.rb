class UsersController < ApplicationController
  def list
    render json: User.all
  end
end
