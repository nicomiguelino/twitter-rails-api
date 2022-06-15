class AuthenticationController < ApplicationController
  def login
    user = User.find_by_email(login_params[:email])

    if user&.authenticate(login_params[:password])
      token = JSONWebToken.encode(user_id: user.id)
      time = Time.now + 24.hours.to_i

      cookies.signed[:token] = {
        value: token,
        httponly: true
      }

      render json: {
        exp: time.strftime('%m-%d-%Y %H:%M'),
        username: user.username
      }, status: :ok
    else
      render json: { error: 'Login failed. Unauthorized.' },
        status: :unauthorized
    end
  end

  private

  def login_params
    params.require(:authentication).permit(:email, :password)
  end
end
