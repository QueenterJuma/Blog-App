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
end
