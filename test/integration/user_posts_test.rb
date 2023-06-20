require 'test_helper'

class UserPostsTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @post = posts(:one)

    visit user_posts_path(@user)
  end

  test "displays user's profile picture" do
    assert page.has_css?('div.image-placeholder')
  end

  test "display user's username" do
    assert page.has_content?(@user.name)
  end

  test 'displays number of posts the user has written' do
    assert page.has_content?("Number of posts: #{@user.posts_counter}")
  end

  test "has post's title" do
    assert page.has_content?(@post.title)
  end

  test "displays post's body" do
    assert page.has_content?(@post.text)
  end

  test 'has first comments on a post' do
    @post.recent_comments.each do |comment|
      assert page.has_content?(comment.text)
    end
  end

  test 'displays number of comments a post has' do
    assert page.has_content?("Comments: #{@post.comments_length}")
  end

  
end