class AddColumnToUsers < ActiveRecord::Migration
  def self.up
    change_table(:users) do |t|
      t.string :name
      t.text :about
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email
      t.string   :authentication_token
      t.string   :image
      t.string   :location
      t.string   :username
    end
  end
end
