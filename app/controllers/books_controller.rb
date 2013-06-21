class BooksController < ApplicationController

	def index

	end

	def new
		@book = Book.new
	end

  def create
    @book = Book.new(params[:book])
    if @book.save
      redirect_to books_path, notice: "Книга была успешно добавленна"
    else
      flash.now[:error] = "Ошибка заполнения формы"
      render 'new'
    end
  end

end