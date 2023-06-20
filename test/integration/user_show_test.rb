require 'test_helper'

class UserShowTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @post = posts(:one)
    visit user_path(@user)
  end

  test 'user show page' do
    assert page.has_content?(@user.name)
  end

  test 'display a user profile photos' do
    assert page.has_css?("img[src='#{@user.photo}']")
  end

  test "renders the number of user's posts" do
    assert page.has_content?("Number of posts: #{@user.posts_counter}")
  end

  test "renders user's bio" do
    assert page.has_content?(@user.bio)
  end

  test "displays user's first 3 posts" do
    @user.best_three_posts.each do |post|
      assert page.has_content?(post.title)
    end
  end

  test "displays a button to view all user's posts" do
    assert page.has_link?('View all posts', href: user_posts_path(@user))
  end

  test 'redirect to post show page' do
    click_link(@post.title, wait: 5, match: :first)
    assert_current_path user_path(@user)
  end

  test 'redirect user to user posts index when user click see all posts' do
    click_link_or_button 'View all posts'
    assert_current_path user_posts_path(@user)
  end
end
