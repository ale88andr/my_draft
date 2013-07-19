class Backend::BookCategoriesController < Backend::ApplicationController

	def new
		@category = BookCategory.new
	end

	def create
		@category = BookCategory.new(params[:category])
		if @category.save
			redirect_to backend_books_path, notice: "Категория #{@category.name} созданна"
		else
			flash_now[:error] = 'Не удалось создать категорию'
			render 'new'
		end
	end

	def show

	end

	def index
		@categories = BookCategory.all
	end

end