class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_post
  
    def create
      @comment = @post.comments.build(comment_params)
      @comment.user = current_user
  
      if @comment.save
        flash[:notice] = 'Comment added successfully.'
        redirect_to post_path(@post)
      else
        flash[:alert] = 'Failed to add comment.'
        redirect_to post_path(@post)
      end
    end
  
    private
  
    def set_post
      @post = Post.find(params[:post_id])
    end
  
    def comment_params
      params.require(:comment).permit(:body)
    end
  end
  