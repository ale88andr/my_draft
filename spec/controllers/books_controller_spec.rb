require 'spec_helper'

describe BooksController do

	before :each do
		sign_in("oQo", "11111111")
	end

	describe "GET 'index'" do

		let!(:book) { stub_model(Book) }
		before :each do
			Book.stub(:all).and_return([])
		end

		it "should receive all" do
			Book.should_receive(:all)
			get :index
		end

		it "should render index template" do
			get :index
			expect(response).to render_template :index
		end

		it "should assigns @books variable" do
			get :index
			expect(assigns(:books)).to eq([])
		end

	end#GET 'index'

	describe "GET 'new'" do

		let!(:book) { mock_model('Book').as_new_record }
		before(:each) do
			Book.stub(:new).and_return(book)
		end

		it "rendered a 'new' template" do
			get :new
			expect(response).to render_template :new
		end

		it "assigns @book variable into a new view" do
			get :new
			expect(assigns[:book]).to eq(book)
		end

	end#GET 'new'

	describe "POST 'create'" do

		let!(:book) { stub_model(Book) }

		let(:params) do
			{
				"title" => "The book",
				"author" => "Author Of Book",
				"description" => "Description",
				"year" => "2010",
				"publisher" => "Publisher",
				"language" => "English",
				"number_of_pages" => "180",
				"ISBN10" => "0000000000",
				"ISBN13" => "0000000000000",
				"link_to_book" => "http://www.book.com/the_book.html",
				"category_of_book" => "1",
			}
		end

		before :each do
			Book.stub(:new).and_return(book)
		end

		it "should sends new message to Book" do
			Book.should_receive(:new).with(params)
			post :create, book: params
		end

		it "should sends save message to Book" do
			book.should_receive(:save)
			post :create
		end

		context "when save return true" do
			before :each do
				book.stub(:save).and_return(true)
			end
			it "redirects to index page" do
				post :create
				expect(page).to redirect_to books_path
			end
			it "exists success flash notice" do
				post :create
				expect(flash[:notice]).not_to be_nil
			end
		end#when save return true

		context "when save return false" do
			before :each do
				book.stub(:save).and_return(false)
				post :create, book: params
			end
			it "redirect to new book form" do
				expect(page).to render_template :new
			end
			it "exists error flash message" do
				expect(flash[:error]).not_to be_nil
			end
			it "assigns @book variable in new view" do
				expect(assigns[:book]).to eq(book)
			end
		end#when save return false

	end#POST 'create'

	describe "GET show" do

		context "when book exists" do

			let!(:book) { stub_model(Book) }

			before :each do
				Book.stub(:find).and_return(book)
			end

			it "sends find message to Book" do
				Book.should_receive(:find).with('1')
				get :show, id: 1
			end
			it "assigns @book variable" do
				get :show, id: 1
				expect(assigns[:book]).to eq(book)
			end
			it "rendered show template" do
				get :show, id: 1
				expect(response).to render_template(:show)
			end

		end#when book exists

		context "when book doesn't exists" do

			before :each do
				Book.stub(:find).and_raise(ActiveRecord::RecordNotFound)
			end

			it "redirect to books index path" do
				get :show, id: 1000
				expect(response).to redirect_to books_path
			end

			it "exists flash error message" do
				get :show, id: 1000
				expect(flash[:error]).not_to be_nil
			end

		end#when book doesn't exists

	end#GET 'show'

	describe "GET 'edit'" do

		let!(:book) { stub_model(Book, id: 1, title: "title") }

		before :each do
			Book.stub(:find).and_return(book)
		end

		it "sends a find message to Book" do
			Book.should_receive(:find).with('1')
			get :edit, id: 1
		end

		it "assigns @book variable" do
			get :edit, id: 1
			expect(assigns(:book)).to eq(book)
		end

		it "rendered edit template" do
			get :edit, id: 1
			expect(response).to render_template :edit
		end

	end#GET 'edit'

	describe "PUT 'update'" do

		@params = {
			title: 		"title",
			author: 	"author",
			year: 		2010,
			publisher: 	"publisher",
			link_to_book: "http://www.book.ru/book/1"
		}

		let!(:book) { stub_model(Book, id: 1) }
		before :each do
			Book.stub(:find).and_return(book)
		end

		it "should receive find message" do
			Book.should_receive(:find)
			put :update, id: book.id, book: @params
		end

		it "should receive update attributes message" do
			book.should_receive(:update_attributes)
			put :update, id: book.id, book: @params
		end

		context "when update_attributes return true" do

			before :each do
				book.stub(:update_attributes).and_return(true)
				put :update, id: 1, book: @params
			end

			it "should redirects to books index" do
				expect(response).to redirect_to books_path
			end

			it "should flash notice" do
				expect(flash[:notice]).not_to be_nil
			end

		end#when update_attributes return true

		context "when update_attributes return false" do

			before :each do
				Book.stub(:update_attributes).and_return(false)
				put :update, id: 1, book: @params
			end

			it "should render edit view" do
				expect(response).to render_template :edit
			end

			it "should assigns @book variable" do
				expect(assigns[:book]).to eq(book)
			end

			it "should exists flash error message" do
				expect(flash[:error]).not_to be_nil
			end

		end#when update_attributes return false

	end#PUT 'update'

	describe "DELETE 'destroy'" do

		let!(:book) { stub_model(Book, id: 1) }

		before :each do
			Book.stub(:find).and_return(book)
			book.stub(:destroy).and_return(true)
		end

		it "sends find message to Book" do
			Book.should_receive(:find)
			delete :destroy, id: book.id
		end

		it "redirects to books index page" do
			delete :destroy, id: book.id
			expect(response).to redirect_to books_path
		end

	end#DELETE 'destroy'

end