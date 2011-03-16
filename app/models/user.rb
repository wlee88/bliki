class User < ActiveRecord::Base
   # attr_accessible :username, :password, :password_confirmation, :location

    attr_accessor :password
    before_save :encrypt_password
    
    #by having assets folder we maintain all images and their integrity. Great if there are newer versions of this app
    has_attached_file :photo, :url => "/assets/user/:id/:basename.:extension",
    :path => ":rails_root/public/assets/products/:id/:basename.:extension"
    has_many :boxes
    has_many :posts

    validates_confirmation_of :password
    validates_presence_of :password, :on => :create
    validates_presence_of :username
    validates_uniqueness_of :username
    
    validates_attachment_size :photo, :less_than => 5.megabytes
    validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/gif']

    def self.authenticate(username, password)
      user = find_by_username(username)
      if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
        user
      else
        nil
      end
    end

    def encrypt_password
      if password.present?
        self.password_salt = BCrypt::Engine.generate_salt
        self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
      end
    end
end
