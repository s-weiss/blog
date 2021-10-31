require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:alice)
    @post = posts(:one)
    @comment = comments(:one)
  end

  test "should get index" do
    get post_comments_url(post_id: @post.id), as: :json
    assert_response :success
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      post post_comments_url(post_id: @post.id), params: { comment: { content: @comment.content, user_id: @user.id } }, as: :json
    end

    assert_response 201
  end

  test "should update comment" do
    patch post_comment_url(@post, @comment), params: { comment: { content: @comment.content } }, as: :json
    assert_response 200
  end

  test "should destroy comment" do
    assert_difference('Comment.count', -1) do
      delete post_comment_url(@post, @comment), as: :json
    end

    assert_response 204
  end
end
