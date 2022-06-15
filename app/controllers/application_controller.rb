class ApplicationController < ActionController::API
  include ActionController::Cookies
  include Core::Exceptions

  private

  def authorize_request
    exceptions = [
      ActiveRecord::RecordNotFound,
      JWT::DecodeError,
      MissingJWTCookieError
    ]

    begin
      token = get_authorization_token
      @decoded = Core::JSONWebToken.decode(token)
      @current_user = User.find(@decoded[:user_id])
    rescue *exceptions => e
      render json: { error: e.message }, status: :unauthorized
    end
  end

  def get_authorization_token
    token = cookies.signed[:token]

    if !token
      raise MissingJWTCookieError.new
    end

    return token
  end
end
