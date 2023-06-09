require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:author) { User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
  let(:post) { Post.new(author: author, title: 'Nature', text: 'I love this!') }
  subject { Comment.new(post: post, author: author, text: 'It is nice') }
  before { subject.save }

  context 'return updated comments counter' do
      it 'increments the post\'s comments_counter on save' do
        expect { subject.save }.to change { post.reload.comments_counter }.by(1)
      end
    end
end