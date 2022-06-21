require 'rails_helper'

RSpec.describe 'API::Users', type: :request do
  describe 'GET /api/users' do
    it 'returns a list of users' do
      get api_users_path
      expect(response.status).to eq(200)
    end

    it 'returns an error', :skip_login do
      get api_users_path
      expect(response.status).to eq(401)
    end
  end
end
