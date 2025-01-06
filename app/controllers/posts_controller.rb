class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update]

  def index
    # Hiển thị bài viết của chính người dùng và bài viết của người khác
    @user_posts = Post.where(user: current_user) # Bài viết của người dùng hiện tại
    @other_posts = Post.where.not(user: current_user) # Bài viết của người khác
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

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    # Cho phép upload ảnh bằng cách thêm :image vào strong parameters
    params.require(:post).permit(:title, :content, :image)
  end
end
