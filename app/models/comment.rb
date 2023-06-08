class Comment
  belongs_to :author, class_name: 'User'
  belongs_to :post, counter_cache: :comments_counter

  def update_comment_counter
    post.increment!(:comments_counter)
  end
end
