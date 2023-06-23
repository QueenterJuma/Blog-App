class PostsController < ApplicationController
  def index
    @user = User.includes(:post, :comment).find(params[:user_id])
    @posts = Post.includes(:comment, :author).where(author_id: @user.id)
  end

  def show
    @post = Post.where(author_id: params[:user_id], id: params[:id]).first
    @comment = Comment.new
    @like = Like.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.post.new(post_param)
    if @post.save
      redirect_to user_post_path(current_user, @post)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.destroy
        format.html { redirect_to user_posts_path(current_user), notice: 'Post was successfully deleted.' }
      end
    end
  end

  private

  def post_param
    params.require(:post).permit(:title, :text)
  end
end
