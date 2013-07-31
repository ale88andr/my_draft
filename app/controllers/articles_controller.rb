class ArticlesController < ApplicationController

  before_filter :findArticleById, :only => [:show]
  before_filter :getCategories, :only => [:index]
  before_filter :getTags, :only => [:show, :index]

  load_and_authorize_resource

  def index
    @articles = Article.includes(:category, :tags).get_articles_by_pages(params[:option], params[:page])
  end

  def show
    @article.increment! :views
  end

  private

    def findArticleById
      @article = Article.includes(:tags, :comments).find(params[:id])
    end

    def getCategories
      @categories = Category.all
    end

    def getTags
      @tags = Tag.all
    end

end