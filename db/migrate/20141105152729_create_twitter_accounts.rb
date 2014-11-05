class CreateTwitterAccounts < ActiveRecord::Migration
  def up
    create_table :twitter_accounts do |t|
      t.string   :screen_name
      t.integer  :user_id
      t.integer  :twitter_id,  limit: 8
      t.string   :token
      t.string   :secret
      t.string   :api_key,     limit: 17, null: false

      t.timestamps
    end

    add_index :twitter_accounts, [:api_key]
    add_index :twitter_accounts, [:twitter_id]
    add_index :twitter_accounts, [:user_id]
  end

  def down
    remove_index :twitter_accounts, [:user_id]
    remove_index :twitter_accounts, [:twitter_id]
    remove_index :twitter_accounts, [:api_key]

    drop_table :twitter_accounts
  end
end
