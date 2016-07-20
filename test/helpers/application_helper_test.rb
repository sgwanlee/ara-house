require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title,         "Ara's House"
    assert_equal full_title("Help"), "Help | Ara's House"
  end
end