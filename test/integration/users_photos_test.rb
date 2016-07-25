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
  	microposts = @user.microposts.where("media is NOT NULL and media != ''")
  	assert_not microposts.empty?
  	microposts.each do |micropost|
      if micropost.has_image?
  		  assert_select "img[src=?]", micropost.media.url
      else
        assert_select "video[src=?]", micropost.media.url
      end
  	end
  end
end
