class Post < ActiveRecord::Base
  has_and_belongs_to_many :boxes
  belongs_to :user
  acts_as_taggable
end
