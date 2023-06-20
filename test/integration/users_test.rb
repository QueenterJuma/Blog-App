require 'test_helper'

class UsersTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    visit root_path
  end

  test 'displays names of all users' do
    assert page.has_content?(@user.name)
  end

  test 'display a user profile photos' do
    assert page.has_css?("img[src='#{@user.photo}']")
  end

  test 'displays the number of posts for each user' do
    assert page.has_content?("Number of posts: #{@user.posts_counter}")
  end

  test "redirects to the user's show page" do
    click_link(@user.id.to_s)
    assert_current_path user_path(@user)
  end
end
