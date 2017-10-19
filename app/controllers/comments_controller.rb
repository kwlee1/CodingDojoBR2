class CommentsController < ApplicationController
  def index
  end
  def create
    @comment = Comment.create(content:params[:content],user:current_user,event:Event.find(params[:event_id]))
    redirect_to :back
  end


end
