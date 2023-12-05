Rails.application.routes.draw do
  get 'users/index'
  devise_for :users
  resources :books
  resources :users, only: [:index]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: 'books#index'
end
