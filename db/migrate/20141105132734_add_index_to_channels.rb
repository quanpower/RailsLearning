class AddIndexToChannels < ActiveRecord::Migration
  def up
    add_index :channels, [:latitude, :longitude]
    add_index :channels, [:public_flag, :last_entry_id, :updated_at], :name => 'channels_public_viewable'
    add_index :channels, [:ranking, :updated_at]
    add_index :channels, :realtime_io_serial_number
    add_index :channels, :slug
    add_index :channels, :user_id
  end

  def down
    remove_index :channels, :user_id
    remove_index :channels, :slug
    remove_index :channels, :realtime_io_serial_number
    remove_index :channels, [:ranking, :updated_at]
    remove_index :channels, :name => 'channels_public_viewable'
    remove_index :channels, [:latitude, :longitude]
  end
end
