require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "api/users#list" do
    it 'returns a list of users' do
      get api_users_list_path
      expect(response.status).to eq(200)
    end
  end
end
