require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:alice)
  end

  test "should get index" do
    get users_url, headers: auth_header, as: :json

    assert_response :success
  end

  test "index should return all users" do
    users = User.all
    get users_url, headers: auth_header, as: :json
    
    returnvalue = JSON.parse(@response.body).map { |u| User.new(u) }

    assert_equal(users, returnvalue)
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { name: @user.name } }, headers: auth_header, as: :json
    end
    response =  JSON.parse(@response.body)

    assert_equal(response["name"], @user.name)
    assert_not_nil(response["id"])
    assert_response 201
  end
end
