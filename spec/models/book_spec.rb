require 'spec_helper'

describe Book do

	it { expect(Book.superclass).to eq(ActiveRecord::Base) }

	context "respond to" do

		subject { Book.new }

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

	context "assosiations" do
		pending # if needed
	end#assosiotions

	describe "validation" do

		describe "with invalid values" do

			it "when title is empty" do
				FactoryGirl.build(:book, title: "").should_not be_valid
			end

			it "when title is long" do
				FactoryGirl.build(:book, title: 'a' * 256).should_not be_valid
			end

			it "when title not uniqueness" do
				FactoryGirl.create(:book, title: 'The Book')
				FactoryGirl.build(:book, title: 'The Book').should_not be_valid
			end

			it "when author empty" do
				FactoryGirl.build(:book, author: '').should_not be_valid
			end

			it "when author long" do
				FactoryGirl.build(:book, author: 'a' * 256).should_not be_valid
			end


			it "when year is empty" do
				FactoryGirl.build(:book, year: '').should_not be_valid
			end

			it "when year is a string" do
				FactoryGirl.build(:book, year: 'nineteen eighty').should_not be_valid
			end

			it "when year is in future" do
				FactoryGirl.build(:book, year: 2025).should_not be_valid
			end

			it "when publisher is empty" do
				FactoryGirl.build(:book, publisher: '').should_not be_valid
			end

			it "when publisher is long" do
				FactoryGirl.build(:book, publisher: 'a' * 256).should_not be_valid
			end

			it "when number_of_pages is string" do
				FactoryGirl.build(:book, number_of_pages: 'two hundred').should_not be_valid
			end

			it "when ISBN10 is string" do
				FactoryGirl.build(:book, ISBN10: 'ten').should_not be_valid
			end

			it "when ISBN10 is longer than 10" do
				FactoryGirl.build(:book, ISBN10: 12345678901).should_not be_valid
			end

			it "when ISBN13 is string" do
				FactoryGirl.build(:book, ISBN13: 'thirteen').should_not be_valid
			end

			it "when ISBN10 is longer than 10" do
				FactoryGirl.build(:book, ISBN13: 12345678901111).should_not be_valid
			end

			it "when link_to_book is not match url format" do
				['http:www.book.com', 'http://book:book', 'book@book.com'].each do |invalid_url|
					FactoryGirl.build(:book, link_to_book: invalid_url).should_not be_valid
				end
			end

			it "when category_of_book is string" do
				FactoryGirl.build(:book, category_of_book: 'first').should_not be_valid
			end

		end#with invalid input data

		describe "with valid input values" do

			it "validation true" do
				FactoryGirl.build(:book).should be_valid
			end

		end#with valid input data

	end#validation

	describe "scopes" do

		subject { Book.last }

		before do
			@book_1 = FactoryGirl.create(:book, created_at: 1.year.ago)
			@book_2 = FactoryGirl.create(:book, created_at: 1.day.ago)
			@book_3 = FactoryGirl.create(:book, created_at: 1.month.ago)
		end

		it "with order by created at acsending" do
			should == [@book_2, @book_3, @book_1]
		end

	end

	describe "before validation" do

		before (:all) do
			@book = FactoryGirl.create(:book, title: "untitelised book name")
		end

		subject { Book.find(@book) }

		its(:title) { should == @book.title.capitalize }
		its(:author) { should == @book.author.capitalize }

	end

end