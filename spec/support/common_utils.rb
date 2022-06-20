RSpec.shared_context 'authentication' do
  def sign_up_params(credentials, except: [])
    { authentication: credentials.except(*except) }
  end

  def login_params(credentials, except: [])
    { authentication: credentials.except(:username, *except) }
  end

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

    post api_login_path, params: sign_up_params(credentials)
  end
end
