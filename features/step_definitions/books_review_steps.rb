Given /^I am a Guest user$/ do
	visit root_path
	page.should have_link('Войти')
end

And /^I visit books page$/ do
	visit books_path
end

Given /^I am a admin user$/ do
	visit new_user_session_path
	filling_signin_form("oQo", "11111111")
	click_button("Войти")
	page.should have_content('oQo')
	page.should have_link('Выход')
end

And /^I should see a new book link and click it$/ do
  page.should have_link('Добавить книгу')
  click_link('Добавить книгу')
  current_path.should == new_book_path
end

And /^I should see a form which contains fields to create new book resourse item$/ do
  visit new_book_path
  within('#new_book') do
    fields = %w[book_title book_author book_year book_description book_publisher book_language book_number_of_pages book_ISBN10 book_ISBN13 book_link_to_book book_category_of_book book_book_img]
    fields.each do |field|
      find_field(field)
    end
  end
end

And /^I filing the form with valid data$/ do
	visit new_book_path
  within('#new_book') do
    fill_in "book_title",             with: 'title'
    fill_in "book_author",            with: 'author'
    fill_in "book_year",              with: 1900
    fill_in "book_description",       with: 'description'
    fill_in "book_publisher",         with: 'publisher'
    fill_in "book_language",          with: 'language'
    fill_in "book_number_of_pages",   with: 1
    fill_in "book_ISBN10",            with: 1111111111
    fill_in "book_ISBN13",            with: 1111111111111
    fill_in "book_link_to_book",      with: 'http://some.book.com/book/1'
    fill_in "book_category_of_book",  with: 1
    #attach_file('book_book_img', '/path/to/image.jpg')
  end
end

And /^I click save button$/ do
  expect{click_button 'Сохранить'}.to change(Book, :count).by(1)
end

Then /^New Book must be added to books$/ do
  expect(Book.find_by_title('title')).to_not be_nil
end

And /^I should see that new book$/ do
  #current_path.should ==
end

When /^I filing the form with invalid data$/ do
  visit new_book_path
  within('#new_book') do
    fill_in "book_title",             with: ''
    fill_in "book_author",            with: ''
    fill_in "book_year",              with: 'One thousand nine hundred'
    fill_in "book_description",       with: ''
    fill_in "book_publisher",         with: ''
    fill_in "book_language",          with: ''
    fill_in "book_number_of_pages",   with: 'one'
    fill_in "book_ISBN10",            with: 'ten one'
    fill_in "book_ISBN13",            with: '13 X one'
    fill_in "book_link_to_book",      with: 'some.book.com'
    fill_in "book_category_of_book",  with: 'one'
    #attach_file('book_book_img', '/path/to/image.jpg')
  end
end

And /^I click save button with invalid data$/ do
  expect{click_button 'Сохранить'}.to change(Book, :count).by(0)
end

Then /^New Book must not be added to books$/ do
  expect(Book.find_by_title('title')).to be_nil
end
