class CreateDevices < ActiveRecord::Migration
  def up
    create_table :devices do |t|
      t.integer  :user_id
      t.string   :title
      t.string   :model
      t.string   :ip_address
      t.integer  :port
      t.string   :mac_address
      t.string   :local_ip_address
      t.integer  :local_port
      t.string   :default_gateway
      t.string   :subnet_mask

      t.timestamps
    end

    add_index :devices, [:mac_address]
    add_index :devices, [:user_id]
  end

  def down
    add_index :devices, [:mac_address]
    add_index :devices, [:user_id]

    drop_table :devices
  end
end
