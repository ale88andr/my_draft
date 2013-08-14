require 'spec_helper'

describe Article do

	subject { Article.new }

	it { Article.superclass.should eq(ActiveRecord::Base) }

	it { should respond_to :title }
	it { should respond_to :content }
	it { should respond_to :category_id }
	it { should respond_to :user_id }
	it { should respond_to :views }
	it { should respond_to :published }

	context "delegate" do
		it { should respond_to :author_username }
	end

	describe "model association" do

		def associated_with_model(associated_with, association_type)
			assoc = Article.reflect_on_association(associated_with)
			assoc.macro.should == association_type
		end

		it "with category" do
			associated_with_model(:category, :belongs_to)
		end

		it "with user" do
			associated_with_model(:user, :belongs_to)
		end

		it "with tag" do
			associated_with_model(:tags, :has_and_belongs_to_many)
		end

		it "with comments" do
			associated_with_model(:comments, :has_many)
		end

	end

	describe "model validation" do

		it "with valid data" do
			FactoryGirl.build(:article).should be_valid
		end

		it "with empty title is invalid" do
			FactoryGirl.build(:article, title: "").should_not be_valid
		end

		it "with long title is invalid" do
			FactoryGirl.build(:article, title: "z" * 256).should_not be_valid
		end

		it "with empty content is invalid" do
			FactoryGirl.build(:article, content: "").should_not be_valid
		end

		it "with empty category is invalid" do
			FactoryGirl.build(:article, category_id: "").should_not be_valid
		end

	end

	describe "model scopes" do

		context "when published or not" do

			before :each do
				@published = FactoryGirl.create(:article, published: true)
				@unpublished = FactoryGirl.create(:article, published: false)
			end

			it ".published" do
				Article.published.should_not include @unpublished
			end

			it ".unpublished" do
				Article.unpublished.should_not include @published
			end

		end

		context "with date constrains" do

			share_examples_for "ordered records" do
				it "by date" do
					scope.should == [@tooday, @week, @month]
				end
			end

			before :each do
				@tooday = FactoryGirl.create(:article)
				@week = FactoryGirl.create(:article, created_at: 1.week.ago + 1)
				@month = FactoryGirl.create(:article, created_at: 1.month.ago + 1)
			end

			context ".last" do

				it_should_behave_like "ordered records" do
					let(:scope) { Article.last }
				end

			end

			context ".tooday" do

				subject { Article.tooday }

				it "not include older that tooday records" do
					should_not include [@week, @month]
				end

				it "include only tooday records" do
					should include @tooday
				end

			end

			context ".week" do

				subject { Article.week }

				it "not include older that week records" do
					should_not include @month
				end

				it "include only week records" do
					should == [@tooday, @week]
				end

			end

			context ".month" do

				it_should_behave_like "ordered records" do
					let(:scope) { Article.month }
				end

			end

		end

	end

end