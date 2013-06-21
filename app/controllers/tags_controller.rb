class TagsController < ApplicationController
  def index
    @tags = Tag.all
  end

  def show
  end

  def create
    @tag = Tag.new(params[:tag])
    if @tag.save
      redirect_to @tag, notice: "Тег успешно созданн"
    else
      flash[:error] = "Не удалось создать тег"
      render "new"
    end
  end

  def destroy
  end

  def new
    @tag = Tag.new
  end
end
