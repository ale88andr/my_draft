require 'spec_helper'

describe BooksController do

	describe "GET 'new'" do

		let!(:book) { mock_model('Book').as_new_record }
		before(:each) do

		end

		it "rendered a 'new' template" do
			Book.stub(:new).and_return(book)
			get :new
			expect(response).to render_template :new
		end

		it "assigns @book variable into a new view" do
			Book.stub(:new).and_return(book)
			get :new
			expect(assigns[:book]).to eq(book)
		end

	end#GET 'new'

	describe "POST 'create'" do

		let!(:book) { stub_model(Book) }

		let!(:params) do
				{
					"title" => "title",
					"author" => "author",
					"year" => '1900',
					"description" => "description",
					"publisher" => "publisher",
					"language" => "language",
					"number_of_pages" => "number_of_pages",
					"ISBN10" => '1111111111',
					"ISBN13" => '1111111111111',
					"link_to_book" => "link_to_book",
					"category_of_book" => '1',
				}
		end

		before(:each) do
			Book.stub(:new).and_return(book)
		end

		it "Sends new to Book class" do
			Book.should_receive(:new).with(params)
			post :create, book: params
		end

		it "Sends save to Book class" do
			book.should_receive(:save)
			post :create
		end

	end#POST 'create'

end