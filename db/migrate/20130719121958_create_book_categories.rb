class CreateBookCategories < ActiveRecord::Migration
  def change
    create_table :book_categories do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
    add_index :book_categories, :name, :unique => true
  end
end
