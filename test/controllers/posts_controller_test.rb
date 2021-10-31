require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:alice)
    @post = posts(:one)
  end

  test "should get index" do
    get posts_url, as: :json
    assert_response :success
  end

  test "should fetch all posts for a user" do
    get for_user_posts_url(user_id: @user.id), as: :json

    assert_not_empty(JSON.parse(@response.body))
    assert_response :success
  end

  test "should fetch no posts if the user did not create any" do
    @user = users(:bob)
    get for_user_posts_url(user_id: @user.id), as: :json

    assert_empty(JSON.parse(@response.body))
  end

  test "should create post" do
    assert_difference('Post.count') do
      post posts_url, params: { post: { content: @post.content, title: @post.title, user_id: @user.id } }, as: :json
    end

    assert_response 201
  end

  test "should show post" do
    get post_url(@post), as: :json
    assert_response :success
  end

  test "should update post" do
    patch post_url(@post), params: { post: { content: @post.content, title: @post.title } }, as: :json
    assert_response 200
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete post_url(@post), as: :json
    end

    assert_response 204
  end
end
