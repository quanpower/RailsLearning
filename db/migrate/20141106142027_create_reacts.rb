class CreateReacts < ActiveRecord::Migration
  def up
    create_table :reacts do |t|
      t.integer  :user_id
      t.string   :name
      t.string   :react_type,            limit: 10
      t.integer  :run_interval
      t.boolean  :run_on_insertion,                 default: true,        null: false
      t.datetime :last_run_at
      t.integer  :channel_id
      t.integer  :field_number
      t.string   :condition,             limit: 15
      t.string   :condition_value
      t.float    :condition_lat
      t.float    :condition_long
      t.float    :condition_elev
      t.integer  :actionable_id
      t.boolean  :last_result,                      default: false
      t.string   :actionable_type,                  default: "Thinghttp"
      t.string   :action_value
      t.string   :latest_value
      t.boolean  :activated,                        default: true
      t.boolean  :run_action_every_time,            default: false

      t.timestamps
    end

    add_index :reacts, [:channel_id, :run_on_insertion]
    add_index :reacts, [:channel_id]
    add_index :reacts, [:run_interval]
    add_index :reacts, [:user_id]
  end

  def down
    remove_index :reacts, [:channel_id, :run_on_insertion]
    remove_index :reacts, [:channel_id]
    remove_index :reacts, [:run_interval]
    remove_index :reacts, [:user_id]

    drop_table :reacts

  end
end
