class Box < ActiveRecord::Base
  has_many :comments
  has_and_belongs_to_many :posts
  belongs_to :user
  has_attached_file :image,
    :storage => :s3,
    :bucket => 'blox-dissertation',
    :path => "/:attachment/:basename.:extension",
    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml"
  acts_as_taggable

  protected  

   def destroy_attached_files
     logger.error "-------------- This is me NOT destroying my attachments"
   end
end
