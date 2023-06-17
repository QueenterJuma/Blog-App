class LikesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    @like = post.like.new(author: current_user)
    puts 'Queen'
    if @like.save
      puts post.id
      redirect_to user_post_path(post.author, post)
    else
      render :new, status: :unprocessable_entity
    end
  end
end
