class Box < ActiveRecord::Base
  has_many :comments
  has_and_belongs_to_many :posts
  belongs_to :user
  has_attached_file :image

  
end
