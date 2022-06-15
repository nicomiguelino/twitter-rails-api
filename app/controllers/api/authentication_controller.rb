class API::AuthenticationController < ApplicationController
  before_action :authorize_request, except: [:login]

  def login
    user = User.find_by_email(login_params[:email])

    if user&.authenticate(login_params[:password])
      token = Core::JSONWebToken.encode(user_id: user.id)

      unless cookies.signed[:token].nil?
        render json: { message: 'Already logged-in.' }, status: :bad_request
        return
      end

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

  private

  def login_params
    params.require(:authentication).permit(:email, :password)
  end
end
