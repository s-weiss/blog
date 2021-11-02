require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:alice)
    @post = posts(:one)
  end

  test "should get index" do
    get posts_url, headers: auth_header, as: :json
    assert_response :success
  end

  test "should fetch all posts for a user" do
    get for_user_posts_url(user_id: @user.id), headers: auth_header, as: :json

    returnvalue = JSON.parse(@response.body)

    assert_not_empty(returnvalue)
    assert_equal(@user.posts, returnvalue.map{ |p| Post.new(p) })
    assert_response :success
  end

  test "should fetch no posts if the user did not create any" do
    @user = users(:bob)
    get for_user_posts_url(user_id: @user.id), headers: auth_header, as: :json

    assert_empty(JSON.parse(@response.body))
  end

  test "should create post" do
    assert_difference('Post.count') do
      post posts_url, params: { post: { content: @post.content, title: @post.title, user_id: @user.id } }, headers: auth_header, as: :json
    end
    post = Post.new(JSON.parse(@response.body))

    # test that the right content was saved
    assert_equal(@post.content, post.content)
    # test that the post was saved
    assert_not_nil(post.id)
    assert_response 201
  end

  test "should show post" do
    get post_url(@post), headers: auth_header, as: :json
    assert_response :success
  end

  test "should update post" do
    patch post_url(@post), params: { post: { content: @post.content, title: @post.title } }, headers: auth_header, as: :json
    assert_response 200
  end

  test "should not update user of a post" do
    bob = users(:bob)
    assert_not_equal(@post.user_id, bob.id)
    
    patch post_url(@post), params: { post: { user_id: bob.id } }, headers: auth_header, as: :json
    
    @post.reload
    assert_not_equal(@post.user_id, bob.id)
  end

  test "should not update the post of another user" do
    bob = users(:bob)
    patch post_url(@post), params: { comment: { content: "bad" } }, headers: auth_header(bob), as: :json
    
    assert_response 401
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete post_url(@post), headers: auth_header, as: :json
    end

    assert_response 204
  end

  test "should not destroy the post of another user" do
    bob = users(:bob)
    delete post_url(@post), headers: auth_header(bob), as: :json

    assert_response 401
  end
end
