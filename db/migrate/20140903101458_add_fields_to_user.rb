class AddFieldsToUser < ActiveRecord::Migration
  def change
  	add_attachment :users,:avatar
  	add_column :users,:remote_avatar_url,:string
  	add_column :users,:bio,:text
  	add_column :users,:location,:string
  	add_column :users,:birthday,:date
  	add_column :users,:time_zone,:text
  end
end
