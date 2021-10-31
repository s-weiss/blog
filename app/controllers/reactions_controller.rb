class ReactionsController < ApplicationController
  # POST /reactions
  def create
    @reaction = Reaction.new(reaction_params)
    @reaction.comment_id = params[:comment_id]

    if @reaction.save
      render json: @reaction, status: :created, location: @comment
    else
      render json: @reaction.errors, status: :unprocessable_entity
    end
  end

  # DELETE /reactions/1
  def destroy
    @reaction = Reaction.find(params[:id])
    @reaction.destroy
  end

  private
    def reaction_params
      params.require(:reaction).permit(:reaction, :user_id)
    end
end
