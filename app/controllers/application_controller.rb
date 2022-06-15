class MissingJWTCookieError < StandardError
  def initialize(msg='JSON Web Token not found.')
    super
  end
end

class ApplicationController < ActionController::API
  include ActionController::Cookies

  def authorize_request
    begin
      token = get_authorization_token
      @decoded = JSONWebToken.decode(token)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { error: e.message }, status: :unauthorized
    rescue MissingJWTCookieError => e
      render json: { error: e.message }, status: :unauthorized
    end
  end

  private

  def get_authorization_token
    token = cookies.signed[:token]

    if !token
      raise MissingJWTCookieError.new
    end

    return token
  end
end
