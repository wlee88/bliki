class PostsController < ApplicationController
   before_filter :authenticate
  in_place_edit_for :post, :title 
  in_place_edit_for :post, :tag
    skip_before_filter :verify_authenticity_token
  #Box.find(:all, :conditions => ["owner = ?", current_user.id])
  
  # GET /posts
  # GET /posts.xml
  
  
  def set_box_desc
    @box = Box.find(params[:id])
    #Get Box ID from parameter
  if params[:value] == ""
      @box.desc = "Click To Edit" #if box id is null, the editor will not show anything, thus give it a string "click to edit"
  else
    @box.desc = params[:value]
  end
    @box.save
    render :update do |page|
    page.replace_html "inplaceedit_" + params[:id], "<div class='inplaceedit'>" + in_place_editor_field (:box, :desc, {}, :cols => 21, :rows => 2) + "</div>"
    end
  end
  
  def set_post_title
    @post = Post.find(params[:id])
    if params[:value] == ""
         @post.title = no_title_defined #if box id is null, the editor will not show anything, thus give it a string "click to edit"
     else
       @post.title = params[:value]
     end
    @post.save!
    render :update do |page|
     # page.call 'alert', 'My message!'
     page.replace_html "workspace", :partial => 'workspace'
    end
  end
  
  def set_post_tags
     @post = Post.find(params[:id])
     if params[:value] == ""
         @post.tag_list = no_tag_text #if box id is null, the editor will not show anything, thus give it a string "click to edit"
     else
       @post.tag_list = params[:value].downcase
     end
     @post.save!
     render :update do |page|
      # page.call 'alert', 'My message!'
      page.reload
     end
   end
  
  def set_post_description
    @post = Post.find(params[:id])
    if params[:value] == ""
         @post.description = "Click to Edit" #if box id is null, the editor will not show anything, thus give it a string "click to edit"
     else
       post.description = params[:value]
     end
    @post.description = params[:value]
    @post.save!
    render :update do |page|
     # page.call 'alert', 'My message!'
     page.replace_html "workspace", :partial => 'workspace'
    end
  end
  
  def index
    if Post.count <= 1
      redirect_to new_post_path #since nothing to show, might as well redirect to new post path
    else
     @posts = Post.find(:all, :order => "updated_at DESC")
     @years = [""]
     @months = [""]
     @posts.each do |post|
     t = post.updated_at
     
     #get years which aren't this year into array.
    
      @years.delete(t.year.to_s)
      @years << t.year.to_s
     
      @months.delete(t.month.to_s)
      @months << t.month.to_s
      

    end
    @years.delete("")
    @months.delete("")
   end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
    
end

  # GET /posts/1
  # GET /posts/1.xml

  
  def show
    
    if params[:delete_favorite]
      current_user.favorite_list.delete(params[:delete_favorite])
      current_user.save
      redirect_to searches_path
    
    elsif params[:post_for_favorite]
      current_user.favorite_list.delete(params[:post_for_favorite])
      current_user.favorite_list << params[:post_for_favorite]
      current_user.save
      redirect_to searches_path
      
    elsif params[:destroy_box_id] 
      @post = Post.find(params[:destroy_post_id])
      @box = Box.find(params[:destroy_box_id])
      
      @post.boxes.delete(@box)
       render :update do |page|
         # page.call 'alert', 'My message!'
         page.replace_html "workspace", :partial => 'workspace'
        end
    else
      @post = Post.find(params[:id])
      @comment = @post.comments.create(params[:comment])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    t1 = Time.now.localtime
    if Post.last.nil? #IF completely empty database, create a post to work on
      @post = Post.create
    end
    
    if Post.last.boxes.empty? #IF the last post has no content whatsoever, use the last post, instead of creating a new one
      @post = Post.last
    else
      @post = Post.create
    end
      @post.title = current_user.username.capitalize + "'s Post (" + get_date_today + ")"
      @post.tag_list = no_tag_text
      @post.user = current_user
      @post.save

      redirect_to edit_post_path(@post)
  end

  # GET /posts/1/edit
  def edit

    @boxes = Box.where("user_id = ?", current_user.id).order("updated_at DESC").paginate(:per_page => 8, :page => params[:page])
    @post = Post.find(params[:id])
    
    respond_to do |format|
        format.html
        format.js {
          render :update do |page|
            # 'page.replace' will replace full "results" block...works for this example
            # 'page.replace_html' will replace "results" inner html...useful elsewhere
            page.replace 'box_paginate_area', :partial => "boxes/box_paginate_area"
            page.replace 'my_box_area', :partial => 'boxes/box_area'
             end
          }
        end
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to(@post, :notice => 'Post was successfully created.') }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(@post, :notice => 'Post was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to my_boxes_path }
      format.xml  { head :ok }
    end
  end
  
  def store
    @post = Post.find(params[:post_id])
    if (params[:id] == "textbox")
     @box = @post.boxes.create(:oftype => "text", :desc => "Click to Edit")
     @box.tag_list = no_tag_text
     @box.save
    else
     @box = @post.boxes << Box.find(params[:id])
      end
    render :update do |page|
     # page.call 'alert', 'My message!'
     page.replace_html "workspace", :partial => 'workspace'
   
  end
  end
  
  
  def update_sort_box
    
        render :update do |page|
          if params[:sort] == "all"
            @boxes = Box.find(:all, :order => "updated_at DESC").paginate(:per_page => 8, :page => params[:page])
          elsif params[:sort] == "images"
         @boxes = Box.where("oftype = ?", "image").order("created_at DESC").paginate(:per_page => 8, :page => params[:page])
       elsif params[:sort] == "text"
         @boxes = Box.where("oftype = ?", "text").paginate(:per_page => 8, :page => params[:page])
        else 
          @boxes = Box.tagged_with(params[:sort]).paginate(:per_page => 8, :page => params[:page])
         end
         if @boxes.count <= 8 
            page.replace 'box_paginate_area', "<div id='box_paginate_area'> </div>"
         end
         page.replace_html "my_box_area", :partial => 'boxes/box_area', :object => @boxes
  
        end
  
   end
  
  def delete_favorite
    redirect_to searches_path
  end 
  
  def update_sort_post_date
    #parse params[:sort] into a date, and then search by month. Explode string by -
    
    
     page.replace_html "my_box_area", :partial => 'boxes/box_area', :object => @posts
  end
   
   def update_sort_post
      @posts = Post.find(:all, :order => "updated_at DESC")
      @years = [""]
      @months = [""]
      @posts.each do |post|
      t = post.updated_at

      #get years which aren't this year into array.

       @years.delete(t.year.to_s)
       @years << t.year.to_s

       @months.delete(t.month.to_s)
       @months << t.month.to_s


     end
     @years.delete("")
     @months.delete("")
         render :update do |page|
            if params[:sort] == "all"
                @posts = Post.find(:all, :order => "updated_at DESC").paginate(:per_page => 20, :page => params[:page])
            else 
              @posts = Post.tagged_with(params[:sort]).paginate(:per_page => 20, :page => params[:page])
            end
         page.replace 'post_collection', :partial => 'post_collection', :object => @boxes
         end

    end

   

  
 end
