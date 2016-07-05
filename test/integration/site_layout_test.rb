require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "layout links" do
    get root_path
    #Non-logged in : Home
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", login_path
    #Non-logged in : Show
    get user_path(@user)
    assert_template 'users/show'
    assert_select "title" , full_title(@user.name)
    #Non-logged in : Sign-up
    get signup_path
    assert_select "title", full_title("Sign up")
    assert_template 'users/new'

    log_in_as(@user)
    #Logged in : Home
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", edit_user_path(@user)
    assert_select "a[href=?]", logout_path
    #Logged in : Edit
    get edit_user_path(@user)
    assert_template 'users/edit'
    assert_select "title" , full_title("Edit user")
    #Logged in : Index
    get users_path
    assert_template 'users/index'
    assert_select "title" , full_title("All users")
    #Logged in : Show
    get user_path(@user)
    assert_template 'users/show'
    assert_select "title" , full_title(@user.name)
  end


end