class Tag < ActiveRecord::Base
  has_and_belongs_to_any :box
  has_and_belongs_to_any :page
  has_many :users, :through => :posts
  has_many :users, :through => :boxes
end
