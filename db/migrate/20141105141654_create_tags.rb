class CreateTags < ActiveRecord::Migration
  def up
    create_table :tags do |t|
      t.string :name

      t.timestamps
    end

    add_index :tags, :name
  end

  def down
    drop_table :tags
  end
end
