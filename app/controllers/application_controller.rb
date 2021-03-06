class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :clear_no_tag_texts_from_posts
  helper_method :clear_d_tag_texts_from_boxes
  helper_method :current_user #obtains current attributes as object
  helper_method :get_boxes #gets current user's Boxes
  helper_method :get_username #Gets Username by current_id 
  helper_method :get_boxes_public #Gets all boxes which are marked public
  helper_method :browser_tag #returns code relevent for browser link viewing. A convenience method.
  helper_method :filler_string 
  helper :all

  
  def clear_no_tag_texts_from_posts
      @posts = Post.tagged_with(no_tag_text)
      @posts.each do |post|
        post.destroy
      end 
  end
  
  def clear_no_tag_texts_from_boxes
     @boxes = Box.tagged_with(no_tag_text)
      @boxes.each do |box|
        box.destroy
      end 
  end
  
  def clear_d_tag_texts_from_boxes
    @boxes = Box.tagged_with("d")
      @boxes.each do |box|
        box.destroy
      end
      @boxes = Box.where("desc = ?", ".")
        @boxes.each do|box|
          box.destroy
        end
        
        @boxes = Box.where("desc = ?", "")
          @boxes.each do|box|
            box.destroy
          end

  end

  def no_tag_text
    "None Defined:(. Click to Edit"
  end
  
  def no_title_text
    "No Title Defined :(. Click To Edit)"
  end
  
  def get_date_today
    t1 = Time.now.localtime
    t1.day.to_s + "/" + t1.month.to_s + "/" + t1.year.to_s
      end
 
  
  def browser_tag(url, imgsrc)
   "<a href='url' class='tu_iframe_800x600'><img src='imgsrc'></a>"
  end

  def get_boxes(user_id)
    @boxes = Box.find(:all, :conditions => ["user_id = ?", user_id])
  end
  
  def get_boxes_public
     @boxes = Box.find(:all, :conditions => ["public = 't'"])
   end
    
  def get_username(user_id)
    @user = User.find_by_id(user_id).username
  end
    
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def authenticate 
    if session[:user_id].nil?
    redirect_to log_in_path
  end
  end
  
  def filler_string
    "---------"
  end

end