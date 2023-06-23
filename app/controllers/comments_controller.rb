class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
  end

  def create
    post = Post.find(params[:post_id])
    @comment = post.comment.new(author: current_user, **comment_param)
    if @comment.save
      redirect_to user_post_path(post.author, post)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.destroy
        format.html do
          redirect_to user_post_path(current_user, Post.find(params[:post_id])),
                      notice: 'Comment was successfully deleted.'
        end
      end
    end
  end

  private

  def comment_param
    params.require(:comment).permit(:text)
  end
end
