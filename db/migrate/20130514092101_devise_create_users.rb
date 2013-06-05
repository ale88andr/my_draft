class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      ## Database authenticatable
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      ## Other user information
      t.string  :username,          :null => false
      t.boolean :show_email,        :null => false, :default => false
      t.string  :user_birth
      t.string  :user_country
      t.integer :user_sex
      t.text    :user_about

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      t.timestamps
    end
    add_index :users, :username,             :unique => true
    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
  end
end
