class RemoveTitleFromBoxes < ActiveRecord::Migration
  def self.up
    remove_column :boxes, :title
  end

  def self.down
    add_column :boxes, :title, :string
  end
end
