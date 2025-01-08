class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @user_posts = Post.where(user: current_user)
    @other_posts = Post.where.not(user: current_user)
  end

  def personal
    @user_posts = current_user.posts
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
  end  

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = 'Post created successfully.'
      redirect_to posts_path
    else
      flash[:alert] = 'Failed to create post. Please check the errors below.'
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = 'Post updated successfully.'
      redirect_to post_path(@post)
    else
      flash[:alert] = 'Failed to update post. Please check the errors below.'
      render :edit
    end
  end

  def destroy
    if current_user.valid_password?(params[:post][:current_password])
      if @post.destroy
        respond_to do |format|
          format.html { redirect_to user_posts_path, notice: 'Post deleted successfully.' }
          format.js   # Xử lý yêu cầu AJAX
        end
      else
        respond_to do |format|
          format.html { redirect_to user_posts_path, alert: 'Failed to delete the post.' }
          format.js   # Xử lý yêu cầu AJAX cho lỗi
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to post_path(@post), alert: 'Incorrect password. Please try again.' }
        format.js   # Xử lý yêu cầu AJAX cho lỗi xác thực
      end
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_user!
    unless @post.user == current_user
      redirect_to posts_path, alert: 'You are not authorized to perform this action.'
    end
  end

  def post_params
    params.require(:post).permit(:title, :content, :image, :current_password)
  end
  
end
