require 'spec_helper'

describe 'books/show.html.haml' do

  let(:params) do
    {
      "title" => "title",
      "author" => "author",
      "description" => "description",
      "year" => 2010,
      "publisher" => "publisher",
      "language" => "language",
      "number_of_pages" => 180,
      "ISBN10" => 1234567891,
      "ISBN13" => 1234567891234,
      "link_to_book" => "http://www.book.com/link_to_book",
      "category_of_book" => 1,
      "book_img" => "book_img"
    }
  end

  let!(:book) { stub_model(Book, params) }

  before :each do
    assign(:book, book)
  end

  it "show a title" do
    render
    expect(rendered).to have_content(book.title)
  end
  it "show a author" do
    render
    expect(rendered).to have_content(book.author)
  end
  it "show a description" do
    render
    expect(rendered).to have_content(book.description)
  end
  it "show a year" do
    render
    expect(rendered).to have_content(book.year)
  end
  it "show a publisher" do
    render
    expect(rendered).to have_content(book.publisher)
  end
  it "show a language" do
    render
    expect(rendered).to have_content(book.language)
  end
  it "show a number_of_pages" do
    render
    expect(rendered).to have_content(book.number_of_pages)
  end
  it "show a ISBN10" do
    render
    expect(rendered).to have_content(book.ISBN10)
  end
  it "show a ISBN13" do
    render
    expect(rendered).to have_content(book.ISBN13)
  end
  it "show a link_to_book" do
    render
    expect(rendered).to have_content(book.link_to_book)
  end
  it "show a category_of_book" do
    render
    expect(rendered).to have_content(book.category_of_book)
  end

end