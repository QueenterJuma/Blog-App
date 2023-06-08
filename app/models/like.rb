class Like
    belongs_to :author, class_name: 'User'
    belongs_to :post, counter_cache: :likes_counter
    
    def update_like_counter
        post.increment!(:likes_counter)
    end
end