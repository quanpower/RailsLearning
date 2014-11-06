class CreateThinghttps < ActiveRecord::Migration
  def up
    create_table :thinghttps do |t|
      t.integer  :user_id
      t.string   :api_key,      limit: 16
      t.text     :url
      t.string   :auth_name
      t.string   :auth_pass
      t.string   :method
      t.string   :content_type
      t.string   :http_version
      t.string   :host
      t.text     :body
      t.string   :name
      t.string   :parse

      t.timestamps
    end

    add_index :thinghttps, [:api_key]
    add_index :thinghttps, [:user_id]
  end

  def down
    remove_index :thinghttps, [:user_id]
    remove_index :thinghttps, [:api_key]

    drop_table :thinghttps
  end
end
