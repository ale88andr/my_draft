require 'spec_helper'

describe Comment do
  
	let!(:comment) { Comment.new }

	subject{comment}

	it { should respond_to :body }
	it { should respond_to :article_id }
	it { should respond_to :user_id }

	it { expect(Comment.superclass).to eq(ActiveRecord::Base) }

	describe "association" do

		context "to user model" do

			it "should associate with user model" do
				assoc = Comment.reflect_on_association(:user)
				assoc.macro.should == :belongs_to
			end

		end

		context "to article model" do

			it "should associate with article model" do
				assoc = Comment.reflect_on_association(:article)
				assoc.macro.should == :belongs_to
			end

		end

	end#association

	describe "comment validations" do

		before :each do
			@params = {
				body: nil,
			}
		end

		context "create comment with invalid data" do

			it "without body" do
				comment = Comment.new(@params)
				expect(comment).not_to be_valid
			end

			it "with to long content" do
				@params[:body] = 'content' * 200
				comment = Comment.new(@params)
				expect(comment).not_to be_valid
			end

		end

		context "create comment with valid data" do

			it "without body" do
				@params[:body] = "content for comment"
				comment = Comment.new(@params)
				expect(comment).to be_valid
			end

		end

	end#comment validations

end#Comment
