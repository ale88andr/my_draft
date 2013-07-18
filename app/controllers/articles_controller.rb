class ArticlesController < ApplicationController

  before_filter :findArticleById, :only => [:show]
  before_filter :getCategories, :only => [:index]
  before_filter :getTags, :only => [:show, :index]

  load_and_authorize_resource

  def index
    @articles = Article
    @articles = case params[:option]
      when 'tooday'     then @articles.tooday
      when 'month'      then @articles.month
      when 'week'       then @articles.week
      when 'top_views'  then @articles.top_views
      else @articles.published
    end
    @articles = @articles.page(params[:page]).per(5) 
  end

  def show
    @article.increment! :views
  end

  private

    def findArticleById
      @article = Article.find(params[:id])
    end

    def getCategories
      @categories = Category.all
    end

    def getTags
      @tags = Tag.all
    end

end