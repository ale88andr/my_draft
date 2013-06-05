class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.references :user
      t.references :category
      t.boolean :published

      t.timestamps
    end
    add_index :articles, :user_id
    add_index :articles, :category_id
  end
end
