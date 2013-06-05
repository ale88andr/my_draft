require "spec_helper"

describe "Аутентификация" do

	subject {page}
	
	describe "Вход" do

		let(:submit) {"Войти"}
		let(:user) {FactoryGirl.build(:user)}

		before {visit new_user_session_path}

		describe "Пустые поля" do
			before {click_button submit}
			it { should have_selector('span', text: 'Сообщение: Invalid email or password.') }
		end

		describe "Неверно заполненные поля" do
			before do
				fill_in "Имя пользователя",	 with:"test_user"
				fill_in "Пароль",			 with:"test_user"
				click_button submit
			end

			it { should have_selector('span', text: 'Сообщение: Invalid email or password.') }
			it { should have_link('Войти', href: new_user_session_path) }

			describe "Правильная работа Flash" do 
				before { click_link "My_Draft" }
				it { should_not have_selector('span', text: 'Сообщение: Invalid email or password.') }
			end
		end

		describe "Верно заполненные поля" do
			before do
				fill_in "Имя пользователя",	 with: user.username
				fill_in "Пароль",			 with: user.password
				click_button submit
			end

			it { should have_selector('span', text: 'Сообщение: Signed in successfully.') }
			it { should have_link('Мой профиль', href: edit_user_registration_path) }
			it { should have_link('Выход', href: destroy_user_session_path) }
		end

	end

end