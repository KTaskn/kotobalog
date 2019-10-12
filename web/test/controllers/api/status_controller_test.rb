require 'test_helper'

class Api::StatusControllerTest < ActionDispatch::IntegrationTest
  test "should get check" do
    get api_status_check_url
    assert_response :success
  end

end
