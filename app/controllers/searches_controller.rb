class SearchesController < ApplicationController
  before_filter :authenticate
  def index
    if params[:search]
       @posts = Post.tagged_with(params[:search])
       #Should show both boxes and posts. And also when viewing box, should show related posts that contain the box.
       @tags = Box.tagged_with(params[:search])
    else
   @tags = Post.tag_counts_on(:tags)
    end
  end
  
end
