require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase

  def setup
  end

  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", @base_title
  end

end
