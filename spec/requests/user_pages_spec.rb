require "spec_helper"

describe "Тестирование модуля User" do

	subject {page}

	describe "Регистрация аккаунта" do

		before {visit new_user_registration_path}

		let(:submit) {"Присоединиться"}

		describe "Проверка входа с пустыми полями" do
			it "Пользователь не будет зарегистрирован" do
				expect { click_button submit }.not_to change(User, :count)
			end
		end

		describe "Проверка входа с заполненными полями" do
			before do
				fill_in "Имя пользователя", 		with: "example"
				fill_in "Ваш электронный адресс",	with: "example@gmail.com"
				fill_in "Пароль",	 				with: "Pa$$w0rd"
				fill_in "Повторите пароль",		 	with: "Pa$$w0rd"
			end

			it "Пользователь должен создасться" do
				expect {click_button submit}.to change(User, :count).by(1)
			end
		end

	end
	
end