class CreateCommands < ActiveRecord::Migration
  def up
    create_table :commands do |t|
      t.string   :command_string
      t.integer  :position
      t.integer  :talkback_id
      t.datetime :executed_at

      t.timestamps
    end

    add_index :commands, [:talkback_id, :executed_at]
  end

  def down
    remove_index :commands, [:talkback_id, :executed_at]

    drop_table :commands
  end
end
