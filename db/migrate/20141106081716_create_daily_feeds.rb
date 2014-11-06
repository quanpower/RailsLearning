class CreateDailyFeeds < ActiveRecord::Migration
  def up
    create_table :daily_feeds do |t|
      t.integer :channel_id
      t.date    :date
      t.string  :calculation, limit: 20
      t.string  :result
      t.integer :field,       limit: 1

    end

    add_index :daily_feeds, [:channel_id, :date]
  end

  def down
    remove_index :daily_feeds, [:channel_id, :date]

    drop_table :daily_feeds
  end
end
