Rails.application.routes.draw do
  devise_for :users
  
  # Routes cho bài viết cá nhân
  get 'personal', to: 'posts#personal', as: 'user_posts'

  # Routes cho bài viết chung
  resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  # Root
  root "posts#index"
end
