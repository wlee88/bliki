class BoxesController < ApplicationController
  # GET /boxes
  # GET /boxes.xml
  
   before_filter :authenticate
  skip_before_filter :verify_authenticity_token
  in_place_edit_for :box, :tag
  in_place_edit_for :box, :desc

  
  def set_box_desc
    @box = Box.find(params[:id])
     if params[:value] == ""
         @box.desc = "Click to edit" #if box id is null, the editor will not show anything, thus give it a string "click to edit"
     else
       @box.desc = params[:value]
     end
     @box.save!
     render :update do |page|
       page.replace_html "workspace", :partial => 'form'
     end
  end
  
  def set_box_tags
     @box = Box.find(params[:id])
     if params[:value] == ""
         @box.tag_list = "No Tags Defined :(" #if box id is null, the editor will not show anything, thus give it a string "click to edit"
     else
       @box.tag_list = params[:value].downcase
     end
     @box.save!
     render :update do |page|
      # page.call 'alert', 'My message!'
      page.replace_html "workspace", :partial => 'form'
     end
   end
  
  def me
    clear_d_tag_texts_from_boxes
    @boxes = Box.where("user_id = ?", current_user.id).order("updated_at DESC").paginate(:per_page => 11, :page => params[:page])
    @posts = Post.where("user_id = ?", current_user.id).order("updated_at DESC").paginate(:per_page => 8, :page => params[:page])
  
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @boxes }
      format.js {
        render :update do |page|
          # 'page.replace' will replace full "results" block...works for this example
          # 'page.replace_html' will replace "results" inner html...useful elsewhere
          page.replace 'my_box_collection', :partial => 'box_collection'
        end
      }
    end
  end
    
  def index
    redirect_to root_path
  end

  # GET /boxes/1
  # GET /boxes/1.xml
  def show
    @box = Box.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @box }
    end
  end

  # GET /boxes/new
  # GET /boxes/new.xml
  def new
    
    if Box.last.nil? #IF completely empty database, create a Box to work on
       @box = Box.new
        @box.public = 't'
        @box.user = current_user
        @box.oftype = "image"
        @box.desc = "."
        @box.save
    elsif Box.last.desc.nil?
      @box = Box.last
    else
       @box = Box.new
        @box.public = 't'
        @box.user = current_user
        @box.oftype = "image"
        @box.desc ="."
        @box.save
    end
    redirect_to(edit_box_path(@box))
  end

  # GET /boxes/1/edit
  def edit
    @box = Box.find(params[:id])
     @box.user = current_user
     @box.save
    @tags = @box.tags
  end

  # POST /boxes
  # POST /boxes.xml
  def create
    @box = Box.new(params[:box])
    @box.user = current_user
    

    respond_to do |format|
      if @box.save
        format.html { redirect_to(@box, :notice => 'Box was successfully created.') }
        format.xml  { render :xml => @box, :status => :created, :location => @box }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @box.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /boxes/1
  # PUT /boxes/1.xml
  def update
    @box = Box.find(params[:id])

    respond_to do |format|
      if @box.update_attributes(params[:box])
        #format.html { redirect_to(@box, :notice => 'Box was successfully updated.') }
        format.html {redirect_to my_boxes_path}
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @box.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /boxes/1
  # DELETE /boxes/1.xml
  def destroy
    @box = Box.find(params[:id])
    @box.destroy
    respond_to do |format|
      format.html { redirect_to(my_boxes_path) }
      format.xml  { head :ok }
    end
  end
  
  def update_sort_box
   
     render :update do |page|
       if params[:sort] == "all"
        @boxes = Box.order("updated_at DESC").paginate(:per_page => 8, :page => params[:page])
       elsif params[:sort] == "images"
      @boxes = Box.where("oftype = ?", "image").order("updated_at DESC").paginate(:per_page => 8, :page => params[:page])
      elsif params[:sort] == "text"
      @boxes = Box.where("oftype = ?", "text").order("updated_at DESC").paginate(:per_page => 8, :page => params[:page])
    else
      @boxes = Box.tagged_with(params[:sort]).order("updated_at DESC").paginate(:per_page => 8, :page => params[:page])
     end
     page.replace_html "my_box_collection", :partial => 'boxes/box_collection', :object => @boxes
   end
  end

  def update_sort_posts
   
     render :update do |page|
       
       if params[:sort] == "all"
         puts "called ALL"
          @posts = Post.order("updated_at DESC").paginate(:per_page => 8, :page => params[:page])
        elsif params[:sort] == filler_string
          @posts = Post.order("updated_at DESC").paginate(:per_page => 8, :page => params[:page])
        else
          @posts = Post.tagged_with(params[:sort]).order("updated_at DESC").paginate(:per_page => 8, :page => params[:page])
        end
     page.replace_html "post_collection", :partial => 'posts/post_collection', :object => @posts
   end
  end  

  def copy_box
    @box_copy = Box.find(params[:id])
    @box = Box.new
    @box.user = current_user
    @box.public = @box_copy.public
    @box.desc = @box_copy.desc
    @box.oftype = @box_copy.oftype
    @box.tag_list = @box_copy.tag_list
    @box.image_file_name = @box_copy.image_file_name
    @box.image_content_type =  @box_copy.image_content_type
    @box.image_file_size = @box_copy.image_file_size
    @box.image_updated_at = @box_copy.image_updated_at
    @box.save

    redirect_to(my_boxes_path)
  end
  
  
  
end


