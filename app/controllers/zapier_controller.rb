class ZapierController < ApplicationController

  def events
    week = Time.now.next_week
    #week = Time.now.weeks_since(2)
    #@events = Event.where(start_date:week.beginning_of_week..week.end_of_week, event_type:[1,3,4])
    #render json: @events.to_json
  end


end
