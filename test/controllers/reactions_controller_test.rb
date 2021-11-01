require "test_helper"

class ReactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reaction = reactions(:one)
  end

  test "should create reaction" do
    assert_difference('Reaction.count') do
      post comment_reactions_url(@reaction.comment), params: { reaction: { reaction: @reaction.reaction, user_id: @reaction.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should destroy reaction" do
    assert_difference('Reaction.count', -1) do
      delete comment_reaction_url(@reaction.comment, @reaction), as: :json
    end

    assert_response 204
  end
end
