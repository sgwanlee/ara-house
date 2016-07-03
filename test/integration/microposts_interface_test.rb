require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test 'micropost sidebar count' do
    log_in_as(@user)
    get root_path
    assert_match "34 microposts", reponse.body
    # User with zero microposts
    other_user = users(:archer)
    log_in_as(other_user)
    get root_path
    assert_match "0 microposts", response.body
    other_user.microposts.create!(content: "A micropost")
    get root_path
    assert_match "1 microposts", response.body
  end
end
