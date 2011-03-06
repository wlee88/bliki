class ChangePostidInComment < ActiveRecord::Migration
  def self.up
    rename_column :comments, :post_id, :box_id
  end

  def self.down
    rename_column :comments, :box_id, :post_id
  end
end
