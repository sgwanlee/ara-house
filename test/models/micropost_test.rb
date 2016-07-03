require 'test_helper'

class MicropostTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    @micropost = @user.microposts.build(content: "Lorem ipsum")
  end

  test "should be valid" do
    assert @micropost.valid?
  end

  test "user_id should be present" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  test "content should be present" do
    @micropost.content = nil
    assert_not @micropost.valid?
  end

  test "content should be at most 140 characters" do
    @micropost.content = "A"*150
    assert_not @micropost.valid?
  end

  test "order should be more recent first" do
    assert_equal microposts(:most_recent), Micropost.first
  end
end
