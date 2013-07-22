# Scenario: Only registered user can access to backend module

When /^I visit a backend url$/ do
	visit backend_users_path
end

Then /^I should redirect to root url$/ do
	page.current_path == root_url
end

And /^I should see error access message$/ do
	page.should have_content('У вас нет прав доступа к этому ресурсу')
end

# --end Scenario: Only registered user can access to backend module

# Scenario: Admin user can access to backend module

Then /^I should see admin resources links$/ do
	within '#backend-dashboard' do
		page.should have_content("Добро пожаловать в панель администрирования")
		page.should have_link('Администрирование пользователей', href: backend_users_path )
		page.should have_link('Администрирование статей', href: backend_articles_path )
		page.should have_link('Администрирование тегов', href: backend_tags_path )
		page.should have_link('Администрирование книг', href: backend_books_path )
		page.should have_link('Администрирование категорий', href: backend_categories_path )
	end
end

# --end Scenario: Admin user can access to backend module