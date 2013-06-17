require 'spec_helper'

describe User do

	let(:user) {User.new}

	subject {user}

	it {should respond_to :username}
	it {should respond_to :email}
	it {should respond_to :password}
	it {should respond_to :password_confirmation}
	it {should respond_to :password_digest}

	it "User is an ActiveRecord model" do
		expect(User.superclass).to eq(ActiveRecord::Base)
	end
	
	it "has email" do
		user.email = "example@email.com"
		expect(user.email).to eq("example@email.com")
	end

	it "responds to username" do
		user.username = "user123"
		expect(user.username).to eq("user123")
	end

	it "responds to password" do
		user.password = "pass"
		expect(user.password).to eq("pass")
	end

	it "responds to password_confirmation" do
		user.password_confirmation = "pass"
		expect(user.password_confirmation).to eq("pass")
	end

	describe "association" do

		context "to article model" do

			it "should associate with article model" do
				assoc = User.reflect_on_association(:articles)
				assoc.macro.should == :has_many
			end

		end

		context "to comment model" do

			it "should associate with comment model" do
				assoc = User.reflect_on_association(:comments)
				assoc.macro.should == :has_many
			end

		end

	end	

	describe "user model validation" do
		
		before :each do
			@params = {
				username: 				"example",
				email: 					"example@example.com",
				password: 				"secret_password",
				password_confirmation: 	"secret_password"
			}
		end

		describe "with wrong input data" do

			after :each do
				user = User.new(@params)
				expect(user).to_not be_valid
			end

			context "email validation" do

				it "is invalid when email is empty" do
					@params[:email] = nil
				end

				it "is invalid when email has wrong format" do
					addresses = %w[user@foo,com user_at_foo.com example.user@foo. foo@bar_vbaz.com foo@bar+baz.com]
					addresses.each do |addr|
						@params[:email] = addr
						user = User.new(@params)
						expect(user).to_not be_valid
					end
				end

				it "email uniqueness" do
					User.create(@params)
				end
				
			end

			context "username validation" do

				it "is invalid when username is empty" do
					@params[:username] = nil
				end

				it "is invalid when username length too long" do
					@params[:username] = 'a' * 51
				end

				it "username uniqueness" do
					User.create(@params)
				end

			end

			context "password validation" do

				it "is invalid when password is empty" do
					@params[:password] = nil
				end

				it "is invalid when password length too short" do
					@params[:password] = @params[:password_confirmation] = '1' * 6
				end

				it "is invalid when password not equal password_confirmation" do
					@params[:password_confirmation] = 'another_secret_password'
				end

			end

		end

		describe "with valid input data" do

			# after :each do
			# 	user = User.new(@params)
			# 	expect(user).to be_valid
			# end

			context "email validation" do

				it "with valid format" do
					addresses = %w[user@foo.com user_at_foo@mail.com foo123@gmail.com]
					addresses.each do |addr|
						@params[:email] = addr
						user = User.new(@params)
						expect(user).to be_valid
					end
				end

			end

			context "username validation" do

				it "with valid values" do
					usernames = %w[example@user 123user user123 I'm_valid_user]
					usernames.each do |username|
						@params[:username] = username
						user = User.new(@params)
						expect(user).to be_valid
					end
				end

			end

		end

	end

end
