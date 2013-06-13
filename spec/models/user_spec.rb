require 'spec_helper'

describe User do

  describe "User model" do

	let(:user) {User.new}

	it "User is an ActiveRecord model" do
		expect(User.superclass).to eq(ActiveRecord::Base)
	end
	
	it "has email" do
		user.email = "example@email.com"
		expect(user.email).to eq("example@email.com")
	end
	it "responds to username" do
		user.password = "pass"
		expect(user.password).to eq("pass")
	end
	it "responds to password" do
		user.password = "pass"
		expect(user.password).to eq("pass")
	end
	it "responds to password_confirmation" do
		user.password_confirmation = "pass"
		expect(user.password_confirmation).to eq("pass")
	end
  end

  describe "Валидации" do
	  before {@user = User.new(username:"ale88andr", email:"ale88andr_example@gmail.com", password:"11111111", password_confirmation:"11111111")}

	  subject {@user}

	  it {should respond_to :username}
	  it {should respond_to :email}
	  it {should respond_to :password}
	  it {should respond_to :password_confirmation}
	  it {should respond_to :password_digest}

	  it {should be_valid}

	  describe "Валидация заполнения поля 'username'" do
	  	before {@user.username = ''}
	  	it {should_not be_valid}
	  end

	  describe "Валидация длинны поля 'username'" do
	  	before {@user.username = 'w' * 51}
	  	it {should_not be_valid}
	  end

	  describe "Уникальность поля 'username'" do
	  	before {@user.username = 'oQo'}
	  	it {should_not be_valid}
	  end

	  describe "Валидация заполнения поля 'email'" do
	  	before {@user.email = ''}
	  	it {should_not be_valid}
	  end

	  describe "Валидация поля 'email' по шаблону" do
	  	before {@user.email = "user@foo,com"}
	  	it {should_not be_valid}
	  	#addresses = %w[user@foo,com user_at_foo.com example.user@foo. foo@bar_vbaz.com foo@bar+baz.com]
	  	#addresses.each do |addr|
	  		#it {email = addr}
	  		#it {should_not be_valid}
	  	#end
	  end

	  describe "Правильное заполнение поля 'email'" do
	  	before {@user.email = 'ale88andr1@gmail.com'}
	  	it {should be_valid}
	  end

	  describe "Уникальность поля 'email'" do
	  	before {@user.email = 'ale88andr@gmail.com'}
	  	it {should_not be_valid}
	  end

	  describe "Валидация заполнения поля 'password'" do
	  	before {@user.password = @user.password_confirmation = ''}
	  	it {should_not be_valid}
	  end

	  describe "Валидация ограничения на минимум поля 'password'" do
	  	before {@user.password = @user.password_confirmation = 'q' * 6}
	  	it {should_not be_valid}
	  end

	  describe "Валидация равенства паролей" do
	  	before {@user.password_confirmation = 'mismatch'}
	  	it {should_not be_save}
	  end

	  #describe "Валидация равенства полей 'password' и 'password_confirmation'" do
	  	#before {@user.password = 'Pa$$w0rd'}
	  	#before {@user.password_confirmation = 'Pa$$w0rd1'}
	  	#it {should_not be_save}
	  #end

  end

end
