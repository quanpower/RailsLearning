class CreatePipes < ActiveRecord::Migration
  def up
    create_table :pipes do |t|
      t.string   :name,       null: false
      t.string   :url,        null: false
      t.string   :slug,       null: false
      t.string   :parse
      t.integer  :cache

      t.timestamps
    end

    add_index :pipes, :slug

  end

  def down
    remove_index :pipes, :slug

    drop_table :pipes
  end
end
