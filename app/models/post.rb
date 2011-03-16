class Post < ActiveRecord::Base
  has_many :boxes
  has_many :pages
  
  accepts_nested_attributes_for :boxes, :allow_destroy => true
end
