class CreateEvents < ActiveRecord::Migration
  def up
    create_table :events do |t|
      t.integer  :timecontrol_id
      t.datetime :run_at

      t.timestamps
    end

    add_index :events, [:run_at]
  end

  def down
    remove_index :events, [:run_at]

    drop_table :events
  end
end
