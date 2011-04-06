class Box < ActiveRecord::Base
  has_many :comments
  has_and_belongs_to_many :posts
  belongs_to :user
  has_attached_file :image,:url => "/system/:attachment/:basename.:extension"

  validates_presence_of :desc
  validates_presence_of :tag_list
  acts_as_taggable

  protected  

   def destroy_attached_files
     logger.error "-------------- This is me NOT destroying my attachments"
   end
end
