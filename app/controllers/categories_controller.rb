class CategoriesController < ApplicationController

  before_filter :getCategoryById, :only => [:show]

  def index
    @categories = Category.all
  end

  def show
    @articles = @category.articles.where("published = ?", true).order("created_at DESC").page(params[:page]).per(5)
  end

  private

    def getCategoryById
      @category = Category.find(params[:id])
    end

end