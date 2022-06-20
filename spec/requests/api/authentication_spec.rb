require 'rails_helper'

RSpec.describe 'API::Authentications', type: :request do
  # TODO: Move to a separate file.
  def sign_up_params(credentials, except: [])
    { authentication: credentials.except(*except) }
  end

  # TODO: Move to a separate file.
  def login_params(credentials, except: [])
    { authentication: credentials.except(:username, *except) }
  end

  before :each do
    @credentials = {
      username: 'steve.harrington',
      email: 'steve.harrington@hawkins.com',
      password: 'best_babysitter_ever'
    }
  end

  describe 'GET /api/auth/sign_up' do
    it 'returns the details of the newly-registered user', :skip_login do
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
end
