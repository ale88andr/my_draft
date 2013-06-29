def filling_signin_form(username,password)
	within('form#new_user') do
		fill_in "user_username", with: username
		fill_in "user_password", with: password
	end
end

# Scenario: Views a list of book

Given /^I am a Guest user$/ do
	visit root_path
	page.should have_link('Войти')
end

And /^I visit index page which contains any books$/ do
	step "Any books exists"
	step "I visit books page"
end

Given /^Any books exists$/ do
	@books = [Book.create(title: "title1", author: "author1", year: 1990, publisher: "publisher1"), Book.create(title: "title2", author: "author2", year: 1992, publisher: "publisher2")]
end

Given /^I visit books page$/ do
	visit books_path
	current_url.should =~ /books/
end

And /^I should see a page with list of books$/ do
	page.should have_link("title1", href: book_path(@books[0]))
	page.should have_link("title2", href: book_path(@books[1]))
end

When /^I click on the "(.*?)" book$/ do |title|
	@book = Book.find_by_title(title)
	visit book_path(@book)
end

Then /^I should see review of book$/ do
	current_url.should =~ /book/
	#book content
	within('#book-show') do
		page.should have_content(@book.title)
		page.should have_content(@book.author)
		page.should have_content(@book.year)
		page.should have_content(@book.publisher)
	end
	#book manage link
	within('#book-manage') do
		page.should have_link("Удалить")
		page.should have_link("Редактировать", href: edit_book_path(@book))
	end
end

#!end --Scenario: Views a list of book

# Scenario: Adding a book with valid params
Given /^I am a admin user$/ do
	visit new_user_session_path
	filling_signin_form("oQo", '11111111')
	click_button("Войти")
	page.should have_content('oQo')
	page.should have_link('Выход')
end

And /^I visit a page which contains fields to create new book resourse item$/ do
	visit new_book_path
	current_url.should =~ /books\/new/
	within('#new_book') do
		page.should have_field("book_title")
		page.should have_field("book_author")
		page.should have_field("book_year")
		page.should have_field("book_publisher")
		page.should have_field("book_description")
		page.should have_field("book_link_to_book")
		page.should have_field("book_language")
		page.should have_field("book_number_of_pages")
		page.should have_button("Сохранить")
	end
end

When /^I fill a new book form with valid params$/ do
	within('form#new_book') do
		fill_in "book_title", with: "title"
		fill_in "book_author", with: "author"
		fill_in "book_year", with: 1990
		fill_in "book_publisher", with: "publisher"

		click_button("Сохранить")
	end
end

Then /^I will see a index books page with successfully message$/ do
	current_path.should eq(books_path)
	expect(page).to have_content("Книга успешно добавленна!")
end

And /^Book must be added into a database$/ do
	expect(Book.find_by_title("title")).not_to be_nil
end

#!end --Scenario: Adding a book with valid params

# Scenario: Adding a book with invalid params

When /^I fill a new book form with invalid params$/ do
	within('form#new_book') do
		fill_in "book_title", with: "bad_title"
		click_button("Сохранить")
	end
end

Then /^I will see a new book page with error message$/ do
	current_url.should =~ /books/
	expect(page).to have_selector('form#new_book')
	expect(page).to have_content("Возникли ошибки при создании новой книги")
end

And /^Book must not be added into a database$/ do
	expect(Book.find_by_title("bad_title")).to be_nil
end

#!end --Scenario: Adding a book with invalid params

# Scenario: Views a non existing book

Given /^The book with id "(.*?)" does not exists in database$/ do |id|
	expect(Book.find_by_id(id)).to be_nil
end

When /^I visit not existing book page$/ do
	visit book_path(1000)
end

Then /^I should see a error message$/ do
	current_path.should eq(books_path)
	expect(page).should have_content("Книги с такими параметрами не существует")
end

#!end --Scenario: Views a non existing book

# Scenario: Deleting single book

Given /^book "(.*?)" exists$/ do |title|
	@book = Book.create(title: title, author:"a", year: 1900, publisher:"p")
	expect(Book.find_by_title(title)).not_to be_nil
end

When /^I delete it$/ do
	visit book_path(@book)
	click_link("Удалить")
end

Then /^book "(.*?)" should not exist in database$/ do |title|
	expect(Book.find_by_title(title)).to be_nil
end

And /^I should not see "(.*?)" book on library page$/ do |title|
	visit books_path
	expect(page).to_not have_content(title)
end

#!end --Scenario: Deleting single book

# Scenario: Edit existent book

When /^I change book title to "(.*?)"$/ do |title|
	visit book_path(@book)
	click_link("Редактировать")
	current_path.should == edit_book_path(@book)
	expect(page).should have_selector("form#edit_book_#{@book.id}")
	within ("form#edit_book_#{@book.id}") do
		fill_in "book_title", with: title
		click_button("Сохранить")
	end
end

And /^book "(.*?)" should exist in database$/ do |title|
	expect(Book.find_by_title(title)).not_to be_nil
end

And /^I should see "(.*?)" book on library page$/ do |title|
	visit books_path
	expect(page).to have_content(title)
end

#!end --Scenario: Edit existent book