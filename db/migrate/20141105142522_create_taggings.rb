class CreateTaggings < ActiveRecord::Migration
  def up
    create_table :taggings do |t|
      t.integer :tag_id
      t.integer :channel_id

      t.timestamps
    end

    add_index :taggings, :tag_id
    add_index :taggings, :channel_id
  end

  def down
    remove_index :taggings, :tag_id
    remove_index :taggings, :channel_id

    drop_table :taggings
  end
end
