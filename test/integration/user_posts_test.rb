require 'test_helper'

class UserPostsTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @post = posts(:one)

    visit user_posts_path(@user)
  end

  test "displays user's profile picture" do
    assert page.has_css?("img[src='#{@user.photo}']")
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
    @post.best_five_comments.each do |comment|
      assert page.has_content?(comment.text)
    end
  end

  test 'displays number of comments a post has' do
    assert page.has_content?("Comments: #{@post.comments_counter}")
  end

  test 'displays number of likes a post has' do
    assert page.has_content?("Likes: #{@post.likes_counter}")
  end

  test 'has a section pagination if there are more posts' do
    assert page.has_css?('div.pagination')
  end

  test 'should redirect to the post details page' do
    click_link(@post.title, match: :first, class: 'post-content')
    assert_current_path user_post_path(@user, @post)
  end
end
