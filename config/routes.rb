Rails.application.routes.draw do
  devise_for :users

  # Routes cho bài viết cá nhân
  get 'personal', to: 'posts#personal', as: 'user_posts'

  # Routes cho bài viết và bình luận
  resources :posts do
    resources :comments, only: [:create]
  end

  # Route admin login, dashboard, and logout
  get '/admin/login', to: 'admin#login', as: 'admin_login'
  post '/admin/authenticate', to: 'admin#authenticate', as: 'admin_authenticate'
  get '/admin', to: 'admin#dashboard', as: 'admin_dashboard'
  delete '/admin/logout', to: 'admin#logout', as: 'admin_logout'

  # Root
  root "posts#index"
end
