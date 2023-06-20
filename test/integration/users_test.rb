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

  # test "redirects to the user's show page" do
  #   click_link_or_button('user-content-details')
  #   assert_current_path user_path(@user)
  # end

  test "redirects to the user's show page" do
    # assert page.has_css?('a.user-content-details', wait: 5)
    click_link("#{@user.id}")
    assert_current_path user_path(@user)
  end
end
