class Books < ActiveRecord::Migration

  def change
    create_table :books do |t|
      t.string      :title
      t.string      :author
      t.integer     :year
      t.text        :description
      t.string      :publisher
      t.string      :language
      t.integer     :number_of_pages
      t.integer     :ISBN10
      t.integer     :ISBN13
      t.string      :link_to_book
      t.integer     :category_of_book
      t.string      :book_img

      t.timestamps
    end
    add_index :books, :title
    add_index :books, :author
  end

end
