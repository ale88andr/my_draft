def filling_signin_form(username,password)
	within('form#new_user') do
		fill_in "user_username", with: username
		fill_in "user_password", with: password
	end
end

Given /^I am a Guest user$/ do
	visit root_path
	page.should have_link('Войти')
end

And /^I visit books page$/ do
	visit books_path
end

Given /^I am a admin user$/ do
	visit new_user_session_path
	filling_signin_form("oQo", '11111111')
	click_button("Войти")
	page.should have_content('oQo')
	page.should have_link('Выход')
end

And /^I visit a page which contains fields to create new book resourse item$/ do
	visit new_book_path
end