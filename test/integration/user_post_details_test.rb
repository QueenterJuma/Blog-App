require 'test_helper'

class UserPostDetailsTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @post = posts(:one)
    @comment = comments(:one)

    visit user_post_path(@user, @post)
  end

  test 'should display the post title' do
    assert page.has_content?(@post.title)
  end

  test 'should display the post author' do
    assert page.has_content?(@post.author.name)
  end

  test 'should display the comments counter for post' do
    assert page.has_content?("Comments: #{@post.comments_length}")
  end

  test 'should display the likes counter for post' do
    assert page.has_content?("Comments: #{@post.likes_length}")
  end

  test 'should display the post content' do
    assert page.has_content?(@post.text)
  end

  test "should display the comment's author" do
    @post.comments.each do |comment|
      assert page.has_content?(comment.author.name)
    end
  end

  test "should display the comment's body" do
    @post.comments.each do |comment|
      assert page.has_content?(comment.text)
    end
  end
end