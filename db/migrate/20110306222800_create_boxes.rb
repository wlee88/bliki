class CreateBoxes < ActiveRecord::Migration
  def self.up
    create_table :boxes do |t|
      t.string :title
      t.boolean :public
      t.string :desc
      t.string :oftype
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :boxes
  end
end
