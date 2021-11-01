require "test_helper"

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test "should reply unauthorized without a proper header" do
    get users_url, as: :json

    assert_response 401
  end
end