require 'spec_helper'

describe Article do

	let!(:article) { Article.new }

	subject {article}

	it{ Article.superclass.should eq(ActiveRecord::Base) }

	it { should respond_to :title }
	it { should respond_to :content }
	it { should respond_to :category_id }
	it { should respond_to :user_id }
	it { should respond_to :views }
	it { should respond_to :published }

	describe "association with models" do

		def associated_with_model(associated_with, association_type)
			assoc = Article.reflect_on_association(associated_with)
			assoc.macro.should == association_type
		end

		it "should associates with category" do
			associated_with_model(:category, :belongs_to)
		end

		it "should associates with user" do
			associated_with_model(:user, :belongs_to)
		end

		it "should associates with tag" do
			associated_with_model(:tags, :has_and_belongs_to_many)
		end

		it "should associates with comments" do
			associated_with_model(:comments, :has_many)
		end

	end

	describe "model validation" do

		before :each do
			@params = {
				title: 		"new_article title",
				content: 	"new_article content",
				category_id: 1 
			}
		end

		context "created article with invalid data" do

			after :each do
				article = Article.new(@params)
				expect(article).not_to be_valid
			end

			it "create article without title" do
				@params[:title] = ''
			end

			it "create article with long title" do
				@params[:title] = 'z' * 500
			end

			it "create article without content" do
				@params[:content] = ''
			end

			it "create article without category" do
				@params[:category_id] = nil
			end

		end

		context "created article with valid data" do

			it {
				article = Article.new(@params)
				expect(article).to be_valid
			}

		end

	end

end