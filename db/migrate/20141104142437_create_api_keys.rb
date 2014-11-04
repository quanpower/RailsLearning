class CreateApiKeys < ActiveRecord::Migration
  def self.up
    create_table :api_keys do |t|
      t.string :api_key, limit: 16
      t.integer :channel_id
      t.integer :user_id
      t.boolean :write_flag, default: false
      t.string :note

      t.timestamps
    end

    add_index :api_keys, :api_key, :unique => true
    add_index :api_keys, :channel_id
  end

  def self.down
    remove_index :api_keys, :channel_id
    remove_index :api_keys, :api_key

    drop_table :api_keys
  end
end
