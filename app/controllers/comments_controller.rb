class CommentsController < ApplicationController

  def create
    result = Comment.create_comment_by_user(current_user, params[:comment], params[:article_id])
    redirect_to article_path(params[:article_id]), notice: result
  end
  
end
