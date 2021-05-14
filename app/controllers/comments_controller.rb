class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save 
      ActionCable.server.broadcast 'comment_channel', content: @comment, nickname: current_user.nickname
      redirect_to item_path(params[:item_id])
    end  
  end

  def comment_params
    params.permit(:text,:item_id).merge(user_id:  current_user.id)
  end
end
