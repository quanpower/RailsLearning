class ChangeComments < ActiveRecord::Migration
  def up
    remove_column :comments, :commenter
    rename_column :comments, :article_id, :channel_id

    add_column :comments, :parent_id, :integer
    add_column :comments, :flags, :integer
    add_column :comments, :user_id, :integer
    add_column :comments, :ip_address, :string
  end

  def down
    remove_column :comments, :ip_address
    remove_column :comments, :user_id
    remove_column :comments, :flags
    remove_column :comments, :parent_id

    rename_column :comments, :channel_id, :article_id
    add_column :comments, :commenter, :string

  end
end
