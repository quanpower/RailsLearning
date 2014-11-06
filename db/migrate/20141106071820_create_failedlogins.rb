class CreateFailedlogins < ActiveRecord::Migration
  def up
    create_table :failedlogins do |t|
      t.string :login
      t.string :password
      t.string :ip_address

      t.timestamps
    end
  end

  def down
    drop_table :failedlogins
  end
end
