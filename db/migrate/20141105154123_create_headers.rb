class CreateHeaders < ActiveRecord::Migration
  def up
    create_table :headers do |t|
      t.string :name
      t.string :value
      t.integer :thinghttp_id

      t.timestamps
    end

    add_index :headers, [:thinghttp_id]
  end

  def down
    remove_index :headers, [:thinghttp_id]

    drop_table :headers
  end
end
