class ChangeFeeds < ActiveRecord::Migration
  def up
    add_index :feeds, [:channel_id, :created_at]
    add_index :feeds, [:channel_id, :entry_id]
  end


  def down
    remove_index :feeds, [:channel_id, :entry_id]
    remove_index :feeds, [:channel_id, :created_at]
  end
end
