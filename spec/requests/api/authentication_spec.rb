require 'rails_helper'

RSpec.describe 'API::Authentications', type: :request do
  before :each do
    @credentials = {
      username: 'steve.harrington',
      email: 'steve.harrington@hawkins.com',
      password: 'best_babysitter_ever'
    }
  end

  describe 'POST /api/auth/sign_up', :skip_login do
    it 'returns the details of the newly-registered user' do
      post api_sign_up_path, params: sign_up_params(@credentials)
      expect(response.status).to eq(200)
    end

    it (
      'returns error message in required fields are ' \
      'are not specified'
    ) do
      post api_sign_up_path,
        params: sign_up_params(@credentials, except: [:password])
      expect(response.status).to eq(400)
    end
  end

  describe 'POST /api/auth/login', :skip_login do
    before :each do
      post api_sign_up_path, params: sign_up_params(@credentials)
    end

    it 'returns a confirmation message on success' do
      post api_login_path, params: login_params(@credentials)
      expect(response.status).to eq(200)
    end

    it 'returns an error message on failed login' do
      invalid_credentials = @credentials.clone
      invalid_credentials[:password] = 'password'

      post api_login_path, params: login_params(invalid_credentials)
      expect(response.status).to eq(401)
    end
  end

  describe 'POST /api/auth/logout' do
    it 'returns a confirmation message on success' do
      post api_logout_path
      expect(response.status).to eq(200)
    end

    it 'returns an error message if unauthorized', :skip_login do
      post api_logout_path
      expect(response.status).to eq(401)
    end
  end
end
