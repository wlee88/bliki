class AddExtrastuffToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :location, :string
    add_column :users, :country, :string
  end

  def self.down
    remove_column :users, :location, :string
    remove_column :users, :country, :string
  end
end
