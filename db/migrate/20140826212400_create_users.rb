class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :display_name

      t.timestamps
    end
    add_index :users, :username, unique: true
  end
end
