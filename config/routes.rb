Rails.application.routes.draw do
  # Define your application routes per the DSL in
  # https://guides.rubyonrails.org/routing.html

  # Defines the root path route ('/')
  root 'api/rest_docs#index'
  post '/graphql', to: 'graphql#execute'

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: '/graphiql',
      graphql_path: '/graphql'
  end

  namespace :api do
    get '/docs', to: 'rest_docs#index', as: 'rest_api_doc'

    scope '/auth' do
      post '/sign_up', to: 'authentication#sign_up', as: 'sign_up'
      post '/login', to: 'authentication#login', as: 'login'
      post '/logout', to: 'authentication#logout', as: 'logout'
    end

    resources :tweets, only: [:index, :create, :show, :destroy, :update]
    resources :users, only: [:index]
  end
end
