require 'spec_helper'

describe "books/index.html.haml" do

	it "shows list of all existing books" do

		book1 = stub_model(Book, id: 1, title: "title1")
		book2 = stub_model(Book, id: 2, title: "title2")
		books = [book1, book2]
		books.stub(:exists?).and_return(true)
		assign(:books, books)
		render
		expect(rendered).to have_link('title1')
		expect(rendered).to have_link('title2')

	end

end#books/index.html.haml