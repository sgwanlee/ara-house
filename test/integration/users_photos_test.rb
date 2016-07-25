require 'test_helper'

class UsersPhotosTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
  	@user = users(:michael)
    log_in_as(@user)
  end

  test "photos page" do
  	get photos_user_path(@user)
  	microposts = @user.microposts.where("picture is NOT NULL and picture != ''")
  	assert_not microposts.empty?
  	microposts.each do |micropost|
  		assert_select "img[src=?]", micropost.picture.url
  	end
  end
end
