require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "api/users#list" do
    it 'returns a list of users' do
      User.create username: 'dustin.henderson',
        email: 'dustin.henderson@hawkins.com',
        password: 'pearly_whites'

      get api_users_list_path
      expect(response.status).to eq(200)
    end
  end
end
