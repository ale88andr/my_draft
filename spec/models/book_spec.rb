require 'spec_helper'

describe Book do
	
	it { expect(Book.superclass).to eq(ActiveRecord::Base) }

	context "model should respond to" do

		let!(:book) { Book.new }

		subject { book }

		it { should respond_to :title }
		it { should respond_to :author }
		it { should respond_to :description }
		it { should respond_to :year }
		it { should respond_to :publisher }
		it { should respond_to :language }
		it { should respond_to :number_of_pages }
		it { should respond_to :ISBN10 }
		it { should respond_to :ISBN13 }
		it { should respond_to :link_to_book }
		it { should respond_to :category_of_book }
		it { should respond_to :book_img }

	end#model should respond to

	context "assosiotions" do
		pending # if needed
	end#assosiotions

	describe "validation" do

		before :each do
			@params = {
				title: 				"title",
				author: 			"author",
				description: 		"description",
				year: 				2010,
				publisher: 			"publisher",
				language: 			"language",
				number_of_pages: 	180,
				ISBN10: 			1234567891,
				ISBN13: 			1234567891234,
				link_to_book: 		"http://www.book.com/link_to_book",
				category_of_book: 	1,
				book_img: 			"book_img"
			}
		end

		describe "with invalid input data" do

			after :each do
				book = Book.new(@params)
				expect(book).to_not be_valid
			end

			context "title validation" do

				it "fails when title is empty" do
					@params[:title] = ''
				end

				it "fails when title is longer than 255 characters" do
					@params[:title] = 'a' * 256
				end

				it "fails when title not uniqueness" do
					Book.create(@params)
				end

			end#title validation

			context "author validation" do

				it "fails when author is empty" do
					@params[:author] = ''
				end

				it "fails when author is longer than 255 characters" do
					@params[:author] = 'a' * 256
				end

			end#author validation

			context "description validation" do
				pending
			end#description validation

			context "year validation" do

				it "fails when year is empty" do
					@params[:year] = ''
				end

				it "fails when year is a string" do
					@params[:year] = 'nineteen eighty'
				end

				it "fails when year is in future" do
					@params[:year] = 2025
				end

			end

			context "publisher validation" do

				it "fails when publisher is empty" do
					@params[:publisher] = ''
				end

				it "fails when publisher is longer than 255 characters" do
					@params[:publisher] = 'a' * 256
				end

			end#year validation

			context "language validation" do
				pending
			end#language validation

			context "number_of_pages validation" do

				it "fails when number_of_pages is string" do
					@params[:number_of_pages] = 'two hundred'
				end

			end#number_of_pages validation

			context "ISBN10 validation" do

				it "fails when ISBN10 is string" do
					@params[:ISBN10] = 'ten'
				end

				it "fails when ISBN10 is more than 10 items" do
					@params[:ISBN10] = 12345678901
				end

			end#ISBN10 validation

			context "ISBN13 validation" do

				it "fails when ISBN13 is string" do
					@params[:ISBN13] = 'thirteen'
				end

				it "fails when ISBN10 is more than 10 items" do
					@params[:ISBN13] = 12345678901111
				end

			end#ISBN13 validation

			context "link_to_book validation" do

				it "fails when link_to_book is not a url" do
					@params[:link_to_book] = 'link_to_book'
				end

			end#link_to_book validation

			context "category_of_book validation" do

				it "fails when category_of_book is string" do
					@params[:category_of_book] = 'first'
				end

			end#category_of_book validation

		end#with invalid input data

		describe "with valid input data" do

			it "should be valid" do
				book = Book.new(@params)
				expect(book).to be_valid
			end

		end#with valid input data

	end#validation

end