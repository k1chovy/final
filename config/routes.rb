Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index, :show, :edit, :update, :destroy]

  # Routes cho bài viết cá nhân
  get 'personal', to: 'posts#personal', as: 'user_posts'

  # Routes cho bài viết và bình luận
  resources :posts do
    resources :comments, only: [:create]
  end

   get 'admin_posts', to: 'posts#admin_index', as: 'admin_posts'
  
  # Route admin login, dashboard, and logout
  get '/admin/login', to: 'admin#login', as: 'admin_login'
  post '/admin/authenticate', to: 'admin#authenticate', as: 'admin_authenticate'
  get '/admin', to: 'admin#dashboard', as: 'admin_dashboard'
  delete '/admin/logout', to: 'admin#logout', as: 'admin_logout'

  # Root
  root "posts#index"
end
