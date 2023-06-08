class Post < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', counter_cache: :post_counter
  has_many :comment
  has_many :like

  def best_five_comment
    comment.order(created_at: :desc).limit(5)
  end
end
