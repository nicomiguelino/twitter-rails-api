Rails.application.routes.draw do
  # Define your application routes per the DSL in
  # https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    get '/docs', to: 'rest_docs#index', as: 'rest_api_doc'

    post '/auth/sign_up', to: 'authentication#sign_up', as: 'sign_up'
    post '/auth/login', to: 'authentication#login', as: 'login'
    post '/auth/logout', to: 'authentication#logout', as: 'logout'

    # TODO: Use `resources` instead.
    # get '/tweets', to: 'tweets#list', as: 'tweets_list'
    # post '/tweets', to: 'tweets#create', as: 'tweets_create'

    # TODO: Fix affected components.
    resources :tweets, only: [:index, :create]

    get '/users', to: 'users#list', as: 'users_list'
  end
end
