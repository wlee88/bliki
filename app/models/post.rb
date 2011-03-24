class Post < ActiveRecord::Base
 
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :boxes
  belongs_to :user
  
  accepts_nested_attributes_for :boxes, :allow_destroy => true
end
