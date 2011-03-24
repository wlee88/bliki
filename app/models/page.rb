class Page < ActiveRecord::Base
  belongs_to :post
  has_many :boxes
end