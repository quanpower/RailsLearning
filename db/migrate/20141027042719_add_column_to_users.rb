class AddColumnToUsers < ActiveRecord::Migration
  def self.up
    change_table(:users) do |t|
      t.string :name
      t.text :about

      t.string   :authentication_token
      t.string   :image
      t.string   :location
      t.string   :username
    end

    add_index :users, :authentication_token, unique: true
  end
end
