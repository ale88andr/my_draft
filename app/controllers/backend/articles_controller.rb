class Backend::ArticlesController < Backend::ApplicationController

  before_filter :findArticleById, :only => [:edit, :update, :show, :destroy]
  before_filter :getCategories, :only => [:new, :edit, :index]
  before_filter :getTags, :only => [:new, :edit, :show, :index]

  def index
    if params[:unpublished]
      @articles = Article.unpublished.page(params[:page]).per(5)
    else
      @articles = Article.order("created_at DESC").page(params[:page]).per(10)
    end
  end

  def show
    @article.increment! :views
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = current_user.articles.new(params[:article])
    if @article.save
      redirect_to @article, notice: "Статья была успешно созданна."
    else
      getCategories
      flash[:error] = "При создании новой статьи возникли ошибки"
      render "new"
    end
  end

  def update
    if @article.update_attributes(params[:article])
      redirect_to @article, notice: 'Статья обновленна.'
    else
      flash[:error] = "При обновлении статьи возникли ошибки"
      getCategories
      getTags
      render "edit"
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_url
  end

  def unpublished
    @articles = Article.unpublished.page(params[:page]).per(5)
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