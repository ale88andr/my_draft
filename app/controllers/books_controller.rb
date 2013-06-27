class BooksController < ApplicationController

	before_filter :findBookById, :only => [:show, :edit, :update, :destroy]

	def index
		@books = Book.all
	end

	def new
		@book = Book.new
	end

	def create
		@book = Book.new(params[:book])
		if @book.save
			redirect_to books_path, notice: "Книга успешно добавленна!"
		else
			flash[:error] = "Возникли ошибки при создании новой книги"
			render "new"
		end
	end

	def show
	end

	def edit
	end

	def update
		if @book.update_attributes(params[:book])
			redirect_to books_path, notice: "Книга успешно обновленна!"
		else
			flash.now[:error] = "Не удалось обновить книгу с заданными параметрами"
			render 'edit'
		end
	end

	def destroy
		@book.destroy
		redirect_to books_path
	end

	private

		def findBookById
			begin
				@book = Book.find(params[:id])
			rescue
				flash[:error] = "Книги с такими параметрами не существует"
				redirect_to books_path
			end
		end

		#if gem 'strong params'
		def book_params
			params.require(:book).permit(:title, :author, :description, :year, :publisher, :language, :number_of_pages, :ISBN10, :ISBN13, :link_to_book, :category_of_book, :book_img)
		end

end