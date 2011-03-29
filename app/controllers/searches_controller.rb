class SearchesController < ApplicationController
  before_filter :authenticate
  def index
    if params[:search]
       @posts = Post.tagged_with(params[:search])
    else
   @tags = Post.tag_counts_on(:tags)
    end
  end
  
end
