class EventsController < InheritedResources::Base
  http_basic_authenticate_with name: "dg717-admin", password: "717dgdg", except: :preview
  before_action :set_event, only: [:show, :edit, :update]

  
  def index 
    @sort = params[:sort] || 'start_date'
    @filter = params[:filter] || 'current'
    @events = Event.to_show(@filter,@sort)
    respond_with(@events)
  end

  def create
    @event = Event.new(event_params)
    @event.save
    if @event.event_type == 5
      @event.start_date = @event.start_date.end_of_month
      @event.save
    end
    redirect_to "/events/"
  end

  def preview 
    @events = Event.for_board
    render layout: false
  end

  def show
    render layout: false
  end

  def edit
  end

  def update
    Rails.logger.debug("in update")
    @event.update(event_params)
    redirect_to "/events/"
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:name, :end_date, :start_date, :event_type, :description, :subtext, :image, :start_time, :end_time,:image_cache,:space)
    end
end

