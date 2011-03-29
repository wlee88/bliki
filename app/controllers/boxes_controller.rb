class BoxesController < ApplicationController
  # GET /boxes
  # GET /boxes.xml
  
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
      # page.call 'alert', 'My message!'
      page.replace_html "workspace", :partial => 'form'
     end
  end
  
  def set_box_tags
     @box = Box.find(params[:id])
     if params[:value] == ""
         @box.tag_list = "No Tags Defined :(" #if box id is null, the editor will not show anything, thus give it a string "click to edit"
     else
       @box.tag_list = params[:value]
     end
     @box.save!
     render :update do |page|
      # page.call 'alert', 'My message!'
      page.replace_html "workspace", :partial => 'form'
     end
   end
  
  def me
    @boxes = Box.all.paginate(:per_page => 60, :page => params[:page])
    
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
    @box = Box.new
    @box.tag_list = "None Defined:(. Click to Edit"
    @box.public = 't'
    @box.save
    
    redirect_to(edit_box_path(@box))
  end

  # GET /boxes/1/edit
  def edit
    @box = Box.find(params[:id])
    @tags = @box.tags
  end

  # POST /boxes
  # POST /boxes.xml
  def create
    @box = Box.new(params[:box])
    @box.owner = current_user.id
    

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
        format.html {redirect_to boxes_path}
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
    puts "destroy called"
    respond_to do |format|
      format.html { redirect_to(my_boxes_path(params(:page))) }
      format.xml  { head :ok }
    end
  end
end
