def filling_form(username, email, password, password_confirmation)
	within('form#new_user') do
		fill_in "user_username", with: username
		fill_in "user_email", with: email
		fill_in "user_password", with: password
		fill_in "user_password_confirmation", with: password_confirmation
	end
end

Given /^I am a guest user$/ do
	visit root_path
	click_link "Присоединиться"
end

When /^I fill in registration form with incorrect data$/ do
	visit new_user_registration_path
	filling_form("1", "example@example", "pass", "pass")
	expect { click_button "Присоединиться" }.not_to change(User, :count)
end

Then /^I should see an error message$/ do
	page.should have_selector('div#error_explanation')
	page.should have_content('Это поле должно иметь следующий формат: examle@mail.com')
	page.should have_content('Должен состоять не менее чем из 8 символов')
end

And /^I should see registration form with my incorrect values in the fields$/ do
	current_url.should =~ /users/ 
	page.should have_selector('input#user_username')
	field_labeled("user_username").value.should == "1"
	page.should have_selector('input#user_email')
	find_field("user[email]").value.should == "example@example"
	page.should have_selector('input#user_password')
	page.should have_selector('input#user_password_confirmation')
end

When /^I fill in registration form with correct data$/ do
	visit new_user_registration_path
	filling_form("example_user", "example_user@example.com", "Pa$$w0rd", "Pa$$w0rd")
end

And /^I click "register" button$/ do
	expect{click_button "Присоединиться"}.to change(User, :count).by(1)
end

Then /^I should redirect on home page$/ do
	current_path.should == root_path
end	

And /^I should see welcome message$/ do
	page.should have_content("Welcome! You have signed up successfully.")
	page.should have_link("Выход")
end

