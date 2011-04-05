class AddUserIdToBoxes < ActiveRecord::Migration
  def self.up
    add_column :boxes, :user_id, :integer
  end

  def self.down
    remove_column :boxes, :user_id
  end
end
