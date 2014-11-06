class CreateTimecontrols < ActiveRecord::Migration
  def up
    create_table :timecontrols do |t|
      t.integer  :user_id
      t.integer  :schedulable_id
      t.string   :schedulable_type,  limit: 50
      t.string   :frequency,         limit: 20
      t.integer  :day,               limit: 1
      t.integer  :hour,              limit: 1
      t.integer  :minute,            limit: 1
      t.integer  :parent_id
      t.datetime :last_event_at
      t.text     :last_response
      t.string   :name
      t.datetime :run_at
      t.integer  :fuzzy_seconds,                default: 0
      t.string   :schedulable_value

      t.timestamps
    end

    add_index :timecontrols, [:frequency, :minute, :hour, :day]
    add_index :timecontrols, [:parent_id]
    add_index :timecontrols, [:run_at]
    add_index :timecontrols, [:schedulable_id, :schedulable_type]
    add_index :timecontrols, [:user_id]
  end

  def down
    remove_index :timecontrols, [:user_id]
    remove_index :timecontrols, [:schedulable_id, :schedulable_type]
    remove_index :timecontrols, [:run_at]
    remove_index :timecontrols, [:parent_id]
    remove_index :timecontrols, [:frequency, :minute, :hour, :day]

    drop_table :timecontrols
  end
end
