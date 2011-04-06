class SearchesController < ApplicationController
  before_filter :authenticate
  def index
    clear_no_tag_texts_from_posts
    if params[:search]
       @posts = Post.tagged_with(params[:search])
       @boxes = Box.tagged_with(params[:search])
       #Should show both boxes and posts. And also when viewing box, should show related posts that contain the box.
       respond_to do |format|
          format.html
          format.js {
            render :update do |page|
             page.replace_html "search_canvas_posts", :partial => 'search_canvas_posts', :object => @posts
              page.replace_html "search_canvas_items", :partial => 'search_canvas_items', :object => @boxes        
            end
          }
        end
    else
      
    clear_no_tag_texts_from_posts  
    clear_no_tag_texts_from_boxes
   @tags = Box.tag_counts_on(:tags)
   respond_to do |format|
       format.html
       format.js {
         render :update do |page|
            page.replace_html "post_collection_main", :partial => "post_collection_main"
         end
       }
     end
    end
    
  end
  
  def update_sort_box

      render :update do |page|
      if params[:sort] == "all" 
        @posts = Post.tagged_with(params[:search]).paginate(:per_page => 20, :page => params[:page])
        @boxes = Box.tagged_with(params[:search]).paginate(:per_page => 20, :page => params[:page])
      elsif params[:sort] == "images"
         @posts = Post.tagged_with(params[:search]).paginate(:per_page => 20, :page => params[:page])
         @boxes = Box.tagged_with(params[:search]).where("oftype = ?", "image").paginate(:per_page => 20, :page => params[:page])
       elsif params[:sort] == "text"
          @posts = Post.tagged_with(params[:search]).paginate(:per_page => 20, :page => params[:page])
          @boxes = Box.tagged_with(params[:search]).where("oftype = ?", "text").paginate(:per_page => 20, :page => params[:page])
       end
       page.replace_html "search_canvas_posts", :partial => 'search_canvas_posts', :object => @posts
       page.replace_html "search_canvas_items", :partial => 'search_canvas_items', :object => @boxes
       page.replace_html "pagination_search", :partial => 'pagination_search'
      end
   end
  
end
