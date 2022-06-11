Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/tweets/', to: 'tweets#list', as: 'tweets'
  get '/users/', to: 'users#list', as: 'users'
end
