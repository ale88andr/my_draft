class Backend::ArticlesController < Backend::ApplicationController

  helper_method :getCategories, :getTags

  before_filter :findArticleById, :only => [:edit, :update, :show, :destroy]
  before_filter :getCategories, :only => [:index]
  before_filter :getTags, :only => [:show, :index]

  def index
    @articles = Article.last.includes(:category, :tags).page(params[:page]).per(10)
  end

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = current_user.articles.new(params[:article])
    if @article.save
      redirect_to backend_article_path(@article), notice: "Статья была успешно созданна."
    else
      flash[:error] = "При создании новой статьи возникли ошибки"
      render "new"
    end
  end

  def update
    if @article.update_attributes(params[:article])
      redirect_to backend_article_path(@article), notice: 'Статья обновленна.'
    else
      flash[:error] = "При обновлении статьи возникли ошибки"
      render "edit"
    end
  end

  def destroy
    @article.destroy
    redirect_to backend_articles_url
  end

  def unpublished
    @articles = Article.unpublished.page(params[:page]).per(5)
    render 'index'
  end

  private

    def findArticleById
      @article = Article.find(params[:id])
    end

    def getCategories
      @categories ||= Category.all
    end

    def getTags
      @tags ||= Tag.all
    end

end