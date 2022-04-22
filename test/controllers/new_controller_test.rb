require "test_helper"

class NewControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get new_edit_url
    assert_response :success
  end
end
