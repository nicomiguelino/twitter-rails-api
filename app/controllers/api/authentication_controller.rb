class API::AuthenticationController < ApplicationController
  before_action :authorize_request, except: [:login, :sign_up]

  def sign_up
    user = User.new(**sign_up_params)

    if user.save
      render json: user, except: [:password_digest]
    else
      render json: { errors: user.errors }, status: :bad_request
    end
  end

  def login
    user = User.find_by_email(login_params[:email])

    if user&.authenticate(login_params[:password])
      unless cookies.signed[:token].nil?
        render json: { message: 'Already logged-in.' }, status: :bad_request
        return
      end

      token = Core::JSONWebToken.encode(user_id: user.id)

      cookies.signed[:token] = {
        value: token,
        httponly: true
      }

      render json: { message: 'Logged in successfully.' }, status: :ok
    else
      render json: { error: 'Login failed. Unauthorized.' },
        status: :unauthorized
    end
  end

  def logout
    begin
      cookies.delete :token
    rescue StandardError => e
      render json: { error: e.message }, status: :bad_request
    else
      render json: { message: 'Logged out successfully.' }, status: :ok
    end
  end

  def is_logged_in
    render json: {
      username: @current_user.username,
      display_name: @current_user.name
    }
  end

  private

  def sign_up_params
    params.require(:authentication).permit(:username, :email, :password)
  end

  def login_params
    params.require(:authentication).permit(:email, :password)
  end
end
