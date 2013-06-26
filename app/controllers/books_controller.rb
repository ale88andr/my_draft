class BooksController < ApplicationController

	before_filter :findBookById, :only => [:show, :edit]

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

	private

		def findBookById
			begin
				@book = Book.find(params[:id])
			rescue
				flash[:error] = "Книги с такими параметрами не существует"
				redirect_to books_path
			end
		end

end