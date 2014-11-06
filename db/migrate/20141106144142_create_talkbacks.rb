class CreateTalkbacks < ActiveRecord::Migration
  def up
    create_table :talkbacks do |t|
      t.string   :api_key,    limit: 16
      t.integer  :user_id
      t.string   :name
      t.integer  :channel_id

      t.timestamps
    end

    add_index :talkbacks, [:api_key]
    add_index :talkbacks, [:user_id]
  end


  def down
    remove_index :talkbacks, [:user_id]
    remove_index :talkbacks, [:api_key]

    drop_table :talkbacks
  end
end
