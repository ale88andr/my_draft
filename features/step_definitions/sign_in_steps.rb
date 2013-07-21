def filling_signin_form(username,password)
	within('form#loginForm') do
		fill_in "user_username", with: username
		fill_in "user_password", with: password
	end
end

Given /^I am a Guest user$/ do
	visit root_path
	page.should have_link('Войти')
end

And /^I visits the signin page$/ do
	visit new_user_session_path
end

When /^I submits invalid signin information$/ do
	filling_signin_form("non_existing_user", "fake_pass")
	User.find_by_username('non_existing_user').should be_nil
end

And /^I click to Signin button$/ do
	click_button("Войти")
end

Then /^I should see an signin error message$/ do
	current_path == new_user_session_path
	page.should have_selector('span.alert', text: "Сообщение: Invalid email or password.")
end

And /^I am user which have an account$/ do
	User.find_by_username('oQo').should_not be_nil
end

When /^I submits valid signin information$/ do
	filling_signin_form("oQo", "11111111")
end

Then /^I redirected to home page and should see my name, profile link and signout link$/ do
	current_path == root_path
	page.should have_content('oQo')
	page.should have_link('Мой профиль')
	page.should have_link('Выход')
	page.should_not have_link('Войти')
end

And /^When I click Sign out, i should see home page whithout my name$/ do
	click_link('Выход')
	current_path == root_path
	page.should_not have_content('oQo')
	page.should have_link('Войти')
	page.should_not have_link('Выход')
end