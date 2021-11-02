require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:alice)
    @post = posts(:one)
    @comment = comments(:one)
  end

  test "should get index" do
    get post_comments_url(post_id: @post.id), headers: auth_header, as: :json

    assert_response :success
  end

  test "index should return all comments for a post with reactions" do
    get post_comments_url(post_id: @post.id), headers: auth_header, as: :json

    comments_with_reactions = JSON.parse(@response.body)
  
    # test that only comments for this post were returned
    assert_equal(@post.comments.map(&:id), comments_with_reactions.map{ |cwr| cwr["id"] })

    comments_with_reactions.each do |cwr|
      # test that reactions are included
      assert_includes(cwr.keys, "reactions")
      
      if cwr["id"] == @comment.id
        # test that all reactions for only this comment got returned
        assert_equal(@comment.reactions.map(&:id), cwr["reactions"].map{ |r| r["id"] })
      end
    end
  end 

  test "should create comment" do
    assert_difference('Comment.count') do
      post post_comments_url(post_id: @post.id), params: { comment: { content: @comment.content, user_id: @user.id } }, headers: auth_header, as: :json
    end

    comment = Comment.new(JSON.parse(@response.body))

    # test that the right content was saved
    assert_equal(@comment.content, comment.content)
    # test that the comment was saved
    assert_not_nil(comment.id)
    assert_response 201
  end

  test "should update comment" do
    patch post_comment_url(@post, @comment), params: { comment: { content: @comment.content } }, headers: auth_header, as: :json
    assert_response 200
  end

  test "should not update the user_id of a comment" do
    bob = users(:bob)
    assert_not_equal(@comment.user_id, bob.id)
    
    patch post_comment_url(@post, @comment), params: { comment: { user_id: bob.id } }, headers: auth_header, as: :json
    
    @comment.reload
    assert_not_equal(@comment.user_id, bob.id)
  end

  test "should not update the comment of another user" do
    bob = users(:bob)
    patch post_comment_url(@post, @comment), params: { comment: { content: "bad" } }, headers: auth_header(bob), as: :json
    
    assert_response 401
  end

  test "should not update the post_id of a comment" do
    other_post = posts(:two)
    assert_not_equal(@comment.post_id, other_post.id)
    
    patch post_comment_url(@post, @comment), params: { comment: { post_id: other_post.id } }, headers: auth_header, as: :json
    
    @comment.reload
    assert_not_equal(@comment.post_id, other_post.id)
  end

  test "should destroy comment" do
    assert_difference('Comment.count', -1) do
      delete post_comment_url(@post, @comment), headers: auth_header, as: :json
    end

    assert_response 204
  end

  test "should not destroy the comment of another user" do
    bob = users(:bob)
    delete post_comment_url(@post, @comment), headers: auth_header(bob), as: :json

    assert_response 401
  end
end
