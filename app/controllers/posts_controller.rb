class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy] # Thêm :destroy vào đây

  def index
    @user_posts = Post.where(user: current_user)
    @other_posts = Post.where.not(user: current_user)
  end

  def personal
    @user_posts = current_user.posts
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: 'Post created successfully.'
    else
      render :new, alert: 'Failed to create post.'
    end
  end

  def edit
    unless @post.user == current_user
      redirect_to posts_path, alert: 'You can only edit your own posts.'
    end
  end

  def update
    if @post.user == current_user && @post.update(post_params)
      redirect_to post_path(@post), notice: 'Post updated successfully.'
    else
      render :edit, alert: 'Failed to update post.'
    end
  end

  def destroy
    if @post.user == current_user
      @post.destroy
      redirect_to user_posts_path, notice: 'Post deleted successfully.'
    else
      redirect_to user_posts_path, alert: 'You can only delete your own posts.'
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :image)
  end
end
