Rails.application.routes.draw do
  devise_for :users
  
  # Routes for posts functionality
  resources :posts, only: [:index, :show, :new, :create, :edit, :update]

  # Set the root path to posts#index
  root "posts#index"
end
