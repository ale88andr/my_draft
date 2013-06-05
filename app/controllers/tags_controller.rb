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
      render "new", notice: "Не удалось создать тег"
    end
  end

  def destroy
  end

  def new
    @tag = Tag.new
  end
end
