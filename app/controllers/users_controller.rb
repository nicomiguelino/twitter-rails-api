class UsersController < ApplicationController
  def list
    render json: User.all, methods: [:tweets]
  end
end
