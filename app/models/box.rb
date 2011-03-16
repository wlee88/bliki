class Box < ActiveRecord::Base
  has_many :comments
  belongs_to :user
  belongs_to :pages
end
