class MissingAuthorizationHeaderError < StandardError; end

class ApplicationController < ActionController::API
  def authorize_request
    begin
      token = get_authorization_token
      @decoded = JSONWebToken.decode(token)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { error: e.message }, status: :unauthorized
    rescue MissingAuthorizationHeaderError => e
      render json: { error: e.message }, status: :unauthorized
    end
  end

  private

  def get_authorization_token
    authorization_header = request.headers['Authorization']

    if !authorization_header
      raise MissingAuthorizationHeaderError.new(
        'Missing \'Authorization\' header.'
      )
    end

    return authorization_header.split(' ').last
  end
end
