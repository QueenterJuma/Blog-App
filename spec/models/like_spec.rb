require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'New user') }
  let(:post) { Post.new(author: user,  title: 'Nature', text: 'I love this!') }
  subject { Like.new(post: post, author: user) }
  before { subject.save }

  it 'method update_likes_counter increments likes_counter by 1' do
    expect { subject.send(:update_likes_counter) }.to change { post.reload.likes_counter }.by(1)
  end
end