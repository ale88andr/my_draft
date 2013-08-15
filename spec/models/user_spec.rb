require 'spec_helper'

describe User do

	subject { User.new }

	it { should respond_to :username }
	it { should respond_to :email }
	it { should respond_to :password }
	it { should respond_to :password_confirmation }
	it { should respond_to :password_digest }

	it { expect(User.superclass).to eq(ActiveRecord::Base) }

	describe "association" do

		it "with article" do
			assoc = User.reflect_on_association(:articles)
			assoc.macro.should == :has_many
		end

		it "with comment" do
			assoc = User.reflect_on_association(:comments)
			assoc.macro.should == :has_many
		end

		it "with role" do
			assoc = User.reflect_on_association(:roles)
			assoc.macro.should == :has_and_belongs_to_many
		end

	end

	describe "validation" do

		context "with invalid data" do

			it "when email is empty" do
				FactoryGirl.build(:user, email: '').should_not be_valid
			end

			it "when email has wrong format" do
				addresses = %w[user@foo,com user_at_foo.com example.user@foo. foo@bar_vbaz.com foo@bar+baz.com]
				addresses.each do |addr|
					FactoryGirl.build(:user, email: addr).should_not be_valid
				end
			end

			it "email uniqueness" do
				email = "example@gmail.com"
				FactoryGirl.create(:user, email: email)
				FactoryGirl.build(:user, email: email).should_not be_valid
			end

			it "when username is empty" do
				FactoryGirl.build(:user, username: '').should_not be_valid
			end

			it "when username length too long" do
				FactoryGirl.build(:user, username: 'a' * 51).should_not be_valid
			end

			it "username uniqueness" do
				username = "example"
				FactoryGirl.create(:user, username: username)
				FactoryGirl.build(:user, username: username).should_not be_valid
			end

			it "when password is empty" do
				FactoryGirl.build(:user, password: '').should_not be_valid
			end

			it "when password length too short" do
					FactoryGirl.build(:user, password_confirmation: '1' * 6).should_not be_valid
			end

			it "when password not equal password_confirmation" do
				FactoryGirl.build(:user, password_confirmation: 'WRONG_PASSWORD_CONFIRMATION').should_not be_valid
			end
		end

		describe "with valid data" do

			it { FactoryGirl.build(:user).should be_valid }

			it "any email format" do
				addresses = %w[user@foo.com user_at_foo@mail.com foo123@gmail.com]
				addresses.each do |addr|
					FactoryGirl.build(:user, email: addr).should be_valid
				end
			end

			it "any username format" do
				usernames = %w[example@user 123user user123 I'm_valid_user]
				usernames.each do |username|
					FactoryGirl.build(:user, username: username).should be_valid
				end
			end

		end

	end

end
