Feature: Review books and it's summary

	Users visiting the book page, to give an opportunity look
	through a list of existing books
	And when user clicked on book, should open a single page with
	describe of a single book
	Only user with role admin can manage books page

	Scenario: Views a list of book
		Given I am a guest user
		And I visit index page which contains any books
		And I should see a page with list of books
		When I click on the "title1" book
		Then I should see review of book

	Scenario: Views a non existing book
		Given The book with id "1000" does not exists in database
		When I visit not existing book page
		Then I should see a error message

	Scenario: Adding a book with valid params
		Given I am a admin user
		And I visit a page which contains fields to create new book resourse item
		When I fill a new book form with valid params
		Then I will see a index books page with successfully message
		And Book must be added into a database

	Scenario: Adding a book with invalid params
		Given I am a admin user
		And I visit a page which contains fields to create new book resourse item
		When I fill a new book form with invalid params
		Then I will see a new book page with error message
		And Book must not be added into a database

	Scenario: Deleting single book
		Given book "Title to delete" exists
		When I delete it
		Then book "title to delete" should not exist in database
	  And I should not see "title to delete" book on library page

	Scenario: Edit existent book
	  Given book "Title to change" exists
	  When I change book title to "Title changed"
	  Then book "Title to change" should not exist in database
	  And book "Title changed" should exist in database
	  And I should see "Title changed" book on library page