require 'spec_helper'

describe Book do

  it "is inherit to ActiveRecord class" do
    expect(Book.superclass).to eq(ActiveRecord::Base)
  end

  context "responds to" do

    let!(:book) { book = Book.new }

    it "title" do
      book.title = "New Title book"
      expect(book.title).to eq("New Title book")
    end

    it "author" do
      book.author = "Some author"
      expect(book.author).to eq("Some author")
    end

    it "description" do
      book.description = "Some description"
      expect(book.description).to eq("Some description")
    end

    it "year" do
      book.year = 1900
      expect(book.year).to eq(1900)
    end

    it "publisher" do
      book.publisher = "Some publisher"
      expect(book.publisher).to eq("Some publisher")
    end

    it "language" do
      book.language = "Some language"
      expect(book.language).to eq("Some language")
    end

    it "number_of_pages" do
      book.number_of_pages = 200
      expect(book.number_of_pages).to eq(200)
    end

    it "ISBN10" do
      book.ISBN10 = 1245673240
      expect(book.ISBN10).to eq(1245673240)
    end

    it "ISBN13" do
      book.ISBN13 = 0021245673240
      expect(book.ISBN13).to eq(0021245673240)
    end

    it "link_to_book" do
      book.link_to_book = 'http://some.book.com/book/1'
      expect(book.link_to_book).to eq('http://some.book.com/book/1')
    end

    it "category_of_book" do
      book.category_of_book = 1
      expect(book.category_of_book).to eq(1)
    end

    it "book_img" do
      book.book_img = 'path/to/image.img'
      expect(book.book_img).to eq('path/to/image.img')
    end

  end#context

end