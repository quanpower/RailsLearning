class ChangeUsers < ActiveRecord::Migration
  def up
    add_column :users, :login, :string
    add_column :users, :password_salt, :string
    add_column :users, :time_zone, :string
    add_column :users, :public_flag, :boolean,  default: false
    add_column :users, :bio, :text
    add_column :users, :website, :string
    add_column :users, :api_key, :string, limit: 16
    add_column :users, :terms_agreed_at, :datetime

    add_index :users, [:login]
    add_index :users, [:api_key]
  end

  def down
    remove_column :users, :login
    remove_column :users, :password_salt
    remove_column :users, :time_zone
    remove_column :users, :public_flag
    remove_column :users, :bio
    remove_column :users, :website
    remove_column :users, :api_key
    remove_column :users, :terms_agreed_at

    remove_index :users, [:login]
    remove_index :users, [:api_key]
  end
end
