class BookCategory < ActiveRecord::Base
  attr_accessible :description, :name

  has_and_belongs_to_many :books, foreign_key: 'book_categories_id'
end
