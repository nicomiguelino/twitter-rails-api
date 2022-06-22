RSpec.shared_context 'authentication' do
  def sign_up_params(credentials, except: [])
    { authentication: credentials.except(:name, *except) }
  end

  def login_params(credentials, except: [])
    { authentication: credentials.except(:name, :username, *except) }
  end

  before :each do |example|
    credentials = {
      name: 'Dustin Henderson',
      username: 'dustin.henderson',
      email: 'dustin.henderson@hawkins.com',
      password: 'pearly_whites'
    }

    @user = User.create(**credentials)

    if example.metadata[:skip_login]
      next
    end

    post api_login_path, params: sign_up_params(credentials)
  end
end
