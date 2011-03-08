class RemoveCountryFromUser < ActiveRecord::Migration
  def self.up
    remove_column :users, :country
  end

  def self.down
    add_column :users, :country, :string
  end
end
