class Book < ActiveRecord::Base
  attr_accessible :title, :author, :year, :description, :publisher, :language, :number_of_pages, :ISBN10, :ISBN13, :link_to_book, :category_of_book
end