Rails.application.routes.draw do
  devise_for :users

  # Routes cho bài viết cá nhân
  get 'personal', to: 'posts#personal', as: 'user_posts'

  # Routes cho bài viết và bình luận
  resources :posts do
    resources :comments, only: [:create]
  end

  # Routes cho bài viết chung và tích hợp routes cho comments
  resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :comments, only: [:create]
  end

  # Root
  root "posts#index"
end
