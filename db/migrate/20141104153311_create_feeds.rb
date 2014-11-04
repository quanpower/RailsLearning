class CreateFeeds < ActiveRecord::Migration
  def self.up
    create_table :feeds do |t|
      t.integer  :channel_id
      t.string   :field1
      t.string   :field2
      t.string   :field3
      t.string   :field4
      t.string   :field5
      t.string   :field6
      t.string   :field7
      t.string   :field8
      t.integer  :entry_id
      t.string   :status
      t.decimal  :latitude,   precision: 15, scale: 10
      t.decimal  :longitude,  precision: 15, scale: 10
      t.string   :elevation
      t.string   :location

      t.timestamps
    end

  end

  def self.down
    drop_table :feeds
  end
end
