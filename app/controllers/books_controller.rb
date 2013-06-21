class BooksController < ApplicationController

	def index

	end

	def new
		@book = Book.new
	end

  def create
    @book = Book.new(params[:book])
    @book.save
    render nothing: true
  end

end