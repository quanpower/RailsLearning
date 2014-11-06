class CreateWindows < ActiveRecord::Migration
  def up
    create_table :windows do |t|
      t.integer  :channel_id
      t.integer  :position
      t.text     :html
      t.integer  :col
      t.string   :title
      t.string   :window_type
      t.string   :name
      t.boolean  :private_flag, default: false
      t.boolean  :show_flag,    default: true
      t.integer  :content_id
      t.text     :options

      t.timestamps
    end

    add_index :windows, [:channel_id]
    add_index :windows, [:window_type, :content_id]
  end

  def down
    remove_index :windows, [:channel_id]
    remove_index :windows, [:window_type, :content_id]

    drop_table :windows
  end
end
