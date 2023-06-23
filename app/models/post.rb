class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comment, dependent: :destroy
  has_many :like, dependent: :destroy

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_save :update_posts_counter

  after_destroy :reduce_posts_counter

  def best_five_comments
    comment.order(created_at: :desc).limit(5)
  end

  private

  def update_posts_counter
    author.increment!(:posts_counter)
  end

  def reduce_posts_counter
    author.decrement!(:posts_counter)
  end
end
