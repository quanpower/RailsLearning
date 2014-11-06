class CreateTweetcontrols < ActiveRecord::Migration
  def up
    create_table :tweetcontrols do |t|
      t.string   :screen_name
      t.string   :trigger
      t.string   :control_type
      t.integer  :control_key
      t.string   :control_string
      t.integer  :user_id

      t.timestamps
    end

    add_index :tweetcontrols, [:screen_name]
    add_index :tweetcontrols, [:user_id]
  end

  def down
    remove_index :tweetcontrols, [:user_id]
    remove_index :tweetcontrols, [:screen_name]

    drop_table :tweetcontrols
  end
end
