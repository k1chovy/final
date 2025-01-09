class AdminController < ApplicationController
    before_action :authenticate_admin!, except: [:login, :authenticate]
  
    def login
      # Giao diện hiển thị form đăng nhập
    end
  
    def authenticate
      if params[:username] == "admin" && params[:password] == "dinhnockichtran"
        session[:admin_logged_in] = true
        redirect_to admin_dashboard_path, notice: 'Logged in successfully!'
      else
        flash[:alert] = 'Invalid username or password.'
        render :login
      end
    end
  
    def dashboard
      @new_posts_count = Post.where("created_at >= ?", 1.day.ago).count
      @new_clients_count = User.where("created_at >= ?", 1.day.ago).count
      @total_posts = Post.count
      @total_comments = Comment.count
      @total_users = User.count
    end
  
    def logout
      session[:admin_logged_in] = nil
      redirect_to admin_login_path, notice: 'Logged out successfully!'
    end
  
    private
  
    def authenticate_admin!
      unless session[:admin_logged_in]
        redirect_to admin_login_path, alert: 'Please log in to access admin panel.'
      end
    end
  end
  