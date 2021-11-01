require "test_helper"

class ReactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reaction = reactions(:one)
  end

  test "should create reaction" do
    assert_difference('Reaction.count') do
      post comment_reactions_url(@reaction.comment), params: { reaction: { reaction: @reaction.reaction } }, headers: auth_header, as: :json
    end

    assert_response 201
  end

  test "should destroy reaction" do
    assert_difference('Reaction.count', -1) do
      delete comment_reaction_url(@reaction.comment, @reaction), headers: auth_header, as: :json
    end

    assert_response 204
  end

  test "should not destroy reaction of another user" do
    delete comment_reaction_url(@reaction.comment, @reaction), headers: auth_header(users(:bob)), as: :json

    assert_response 401
  end
end
