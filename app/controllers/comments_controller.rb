class CommentsController < ApplicationController
   before_filter :authenticate
  def create
      @box = Box.find(params[:box_id])
      @comment = @box.comments.create(params[:comment])
      redirect_to box_path(@box)
    end
    
    def destroy
       @box = Box.find(params[:box_id])
       @comment = @box.comments.find(params[:id])
       @comment.destroy
       redirect_to box_path(@box)
     end
end
