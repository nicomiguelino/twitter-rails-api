RSpec.shared_context 'authentication' do
  before :each do |example|
    if example.metadata[:skip_login]
      next
    end

    credentials = {
      username: 'dustin.henderson',
      email: 'dustin.henderson@hawkins.com',
      password: 'pearly_whites'
    }

    @user = User.create(**credentials)

    post api_login_path,
      params: { authentication: credentials.except(:username) }
  end
end
