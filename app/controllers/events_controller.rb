class EventsController < ApplicationController
  def index
    @events_in_state = Event.where(state: current_user.state)
    @events_out = Event.where.not(state: current_user.state)
  end
  def show
    @event = Event.find(params[:id])
    @comments = Comment.where(event: @event)
  end 
  def edit
    @event = Event.find(params[:id])
  end 
  def update 
    @event = Event.find(params[:id])
    @event.name = event_helper[:name]
    @event.date = event_helper[:date]
    @event.city = event_helper[:city]
    @event.state = event_helper[:state]
    if @event.save 
      redirect_to events_path 
    else 
      flash[:errors] = @event.errors.full_messages 
      redirect_to :back 
    end 
  end 
  def create
    @event = Event.new(event_helper)
    if @event.save
        redirect_to events_path
    else
        flash[:errors] = @event.errors.full_messages
        redirect_to events_path
    end
  end 
  def destroy
    @event = Event.find(params[:id])
    @event.delete 
    redirect_to events_path 
  end 

  
  def add_attendee 
    @event = Event.find(params[:id])
    @event.attendees_user << current_user
    @event.save
    redirect_to events_path
  end

  def remove_attendee
      @event = Event.find(params[:id])
      @event.attendees_user.delete(User.find(current_user.id))
      redirect_to events_path
  end

  private
  def event_helper
      params.require(:event).permit(:name,:date,:city,:state).merge(user:current_user) if params[:event].present?
  end
end
