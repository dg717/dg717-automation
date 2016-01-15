class EventsController < InheritedResources::Base
  before_action :set_event, only: [:show, :edit, :update]
  
  def index 
    @events = Event.all
    respond_with(@events)
  end

  def create
    @event = Event.new(event_params)
    @event.save
    if @event.event_type == 5
      @event.start_date = @event.start_date.end_of_month
      @event.save
    end
    redirect_to "/events/index"
  end

  def preview 
    @events = Event.all
    render layout: false
  end

  def edit
  end

  def update
    Rails.logger.debug("in update")
    @event.update(event_params)
    redirect_to "/events/index"
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:name, :end_date, :start_date, :event_type, :description, :subtext, :image, :start_time, :end_time,:image_cache,:space)
    end
end

