class CommentsController < ApplicationController

  def create
  	@article = Article.find(params[:article_id])
  	@comment = @article.comments.new(params[:comment])
  	@comment.user_id = current_user.id
  	if @comment.save
  		redirect_to article_path(@article), notice:"Ваш комментарий добавлен к статье"
  	else
  		redirect_to article_path(@article), notice:"Возникли ошибки при добавлении комментария"
  	end
  end
  
end
