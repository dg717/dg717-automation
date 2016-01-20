class EventsController < InheritedResources::Base
  before_action :set_event, only: [:show, :edit, :update]
  
  def index 
    @events = Event.all
    respond_with(@events)
  end

  def create
    Rails.logger.debug("in create")
    @event = Event.new(event_params)
    @event.save
    respond_with(@event)
  end

  def edit
  end

  def update
    Rails.logger.debug("in update")
    @event.update(event_params)
    redirect_to :index
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:name, :from, :to, :type, :description, :subtext, :image, :start_time, :end_time,:image_cache)
    end
end

