class BookCategoriesBooks < ActiveRecord::Migration
  def change
    create_table :book_categories_books, id: false do |t|
      t.integer :book_categories_id
      t.integer :book_id
    end
    add_index :book_categories_books, :book_categories_id
    add_index :book_categories_books, :book_id
  end
end
