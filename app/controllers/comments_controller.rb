class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to "/prototypes/#{@comment.prototype_id}"
    else
      @prototype = Prototype.find(@comment.prototype_id)
      @comments = Comment.where(prototype_id: @comment.prototype_id)
      render 'prototypes/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
