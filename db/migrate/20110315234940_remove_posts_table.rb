class RemovePostsTable < ActiveRecord::Migration
  def self.up
    drop_table :posts
  end

  def self.down
    create_table :posts do |t|
      t.string :title
      t.string :description
      t.integer :row
      t.integer :order
      t.references :box
      t.references :user

      t.timestamps
    end
  end
end
