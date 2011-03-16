class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.references :post
      t.references :box
      t.integer :order

      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
