require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test 'micropost interface' do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    assert_select 'input[type=file]'
    # Invalid submission
    assert_no_difference "Micropost.count" do
      post microposts_path, micropost: {content: ""}
    end
    assert_select 'div#error_explanation'
    # Valid submission
    content = "!23"
    image = fixture_file_upload('test/fixtures/rails.png', 'image/png')
    assert_difference "Micropost.count", 1 do
      post microposts_path, micropost: {content: content, media: image}
    end
    @micropost = assigns(:micropost)
    assert @micropost.media?
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
    # No video_tag
    assert_select "video[src=?]", false, @micropost.media.url
    # image_tag
    assert_select "img[src=?]", @micropost.media.url
    # Delete post
    assert_select "a", text: "delete"
    first_micropost = @user.microposts.paginate(page: 1).first
    assert_difference "Micropost.count", -1 do
      delete micropost_path(first_micropost)
    end
    # Visit different user (no delete links)
    log_in_as(users(:archer))
    assert_select 'a', text:"delete", count: 0

  end
end
