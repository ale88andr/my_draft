class Backend::CategoriesController < Backend::ApplicationController

  before_filter :getCategoryById, :only => [:edit, :update, :destroy, :show]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      redirect_to @category, notice: "Категория успешно созданна"
    else
      render "new"
    end
  end

  def destroy
    @category.destroy
    redirect_to category_path, notice: "Категория удаленна"
  end

  def edit
  end

  def update
    if @category.update_attributes(params[:category])
      redirect_to @category, notice:"Категория обновлена"
    else
      render 'edit', alert:"Не удалось обновить категорию"
    end
  end

  def show
    @articles = @category.articles.where("published = ?", true).order("created_at DESC").page(params[:page]).per(5)
  end

  private

    def getCategoryById
      @category = Category.find(params[:id])
    end

end