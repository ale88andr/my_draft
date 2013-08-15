require 'spec_helper'

describe Comment do

	subject { Comment.new }

	it { should respond_to :body }
	it { should respond_to :article_id }
	it { should respond_to :user_id }

	it { expect(Comment.superclass).to eq(ActiveRecord::Base) }

	describe "delegate" do
		it { should respond_to :author_username }
	end

	describe "association" do
		it "with user" do
			assoc = Comment.reflect_on_association(:user)
			assoc.macro.should == :belongs_to
		end

		it "with article" do
			assoc = Comment.reflect_on_association(:article)
			assoc.macro.should == :belongs_to
		end
	end#association

	describe "comment validations" do

		before :each do
			@params = {body: nil}
		end

		context "with invalid data" do
			it "without body" do
				comment = Comment.new(@params)
				expect(comment).not_to be_valid
			end

			it "with too long content" do
				@params[:body] = 'content' * 200
				comment = Comment.new(@params)
				expect(comment).not_to be_valid
			end
		end

		context "with valid data" do
			it "with body" do
				@params[:body] = "content for comment"
				comment = Comment.new(@params)
				expect(comment).to be_valid
			end
		end
	end#comment validations
end#Comment
