class AddOwnerToBoxes < ActiveRecord::Migration
  def self.up
    add_column :boxes, :owner, :integer
  end

  def self.down
    remove_column :boxes, :owner;
  end
end
