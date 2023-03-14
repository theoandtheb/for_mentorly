require "test_helper"

class GotoControllerTest < ActionDispatch::IntegrationTest
  test "should get send_to" do
    get goto_send_to_url
    assert_response :success
  end
end
