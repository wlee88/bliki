class BoxesPostsJoinTable < ActiveRecord::Migration
  def self.up
    create_table :boxes_posts, :id => false do |t|
      t.integer :box_id
      t.integer :post_id
    end
  end

  def self.down
    drop_table :boxes_posts
  end
end
