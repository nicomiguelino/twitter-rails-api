Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    post '/auth/login', to: 'authentication#login', as: 'login'

    get '/tweets', to: 'tweets#list', as: 'tweets_list'
    post '/tweets', to: 'tweets#create', as: 'tweets_create'

    get '/users', to: 'users#list', as: 'users_list'
  end
end
