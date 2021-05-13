class CommentsController < ApplicationController
  def create
    @comments = Comment.all
    @comment = Comment.new(comment_params)
    if @comment.save 
      ActionCable.server.broadcast 'comment_channel', content: @comment
      redirect_to item_path(params[:item_id])
    end  
  end

  def comment_params
    params.permit(:text,:item_id).merge(user_id:  current_user.id)
  end
end
