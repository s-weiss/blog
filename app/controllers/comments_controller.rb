class CommentsController < ApplicationController
    before_action :set_comment, only: [:show, :update, :destroy]

    # GET /comments
    def index
      @comments = Comment.includes(:reactions).where(post_id: params[:post_id])
  
      render json: @comments, include: :reactions
    end
  
    # POST /comments
    def create
      @comment = Comment.new(comment_params)
      @comment.post_id = params[:post_id]
      @comment.user_id = @current_user.id
  
      if @comment.save
        render json: @comment, status: :created, location: @post
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /comments/1
    def update
      if @current_user.id != @comment.user_id
        head :unauthorized
      elsif @comment.update(comment_params)
        render json: @comment
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /comments/1
    def destroy
      if @current_user.id == @comment.user_id
        @comment.destroy
      else
        head :unauthorized
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_comment
        @comment = Comment.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def comment_params
        params.require(:comment).permit(:content)
      end
end
