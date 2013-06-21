require 'spec_helper'

describe "books/new.html.haml" do
	
	before (:each) do
		book = mock_model("Book").as_new_record.as_null_object
		assign(:book, book)
		render
	end

	context "Page should have element" do

		it "form with id new_book" do
			expect(rendered).should have_selector('form#new_book')
		end

		it "form with id new_book has book title" do
			expect(rendered).should have_selector('#book_title')
		end

		it "form with id new_book has book author" do
			expect(rendered).should have_selector('#book_author')
		end

		it "form with id new_book has book description" do
			expect(rendered).should have_selector('#book_description')
		end

		it "form with id new_book has book year" do
			expect(rendered).should have_selector('#book_year')
		end

		it "form with id new_book has book publisher" do
			expect(rendered).should have_selector('#book_publisher')
		end

		it "form with id new_book has book language" do
			expect(rendered).should have_selector('#book_language')
		end

		it "form with id new_book has book numbers_of_pages" do
			expect(rendered).should have_selector('#book_numbers_of_pages')
		end

		it "form with id new_book has book ISBN10" do
			expect(rendered).should have_selector('#book_ISBN10')
		end

		it "form with id new_book has book ISBN13" do
			expect(rendered).should have_selector('#book_ISBN13')
		end

		it "form with id new_book has book link_to_book" do
			expect(rendered).should have_selector('#book_link_to_book')
		end

		it "form with id new_book has book category_of_book" do
			expect(rendered).should have_selector('#book_category_of_book')
		end

		it "form with id new_book has book book_img" do
			expect(rendered).should have_selector('#book_book_img')
		end

		it "form with id new_book has book link_to_book" do
			expect(rendered).should have_button('Сохранить')
		end

	end

end




