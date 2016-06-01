class Event < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  default_scope -> {where(["start_date >= ?",Date.today]).order("start_date")}
  #type ["Event",1],["Popup",2],["Happy Hour",3],["Party",4],["NewTenant",5]]

  def self.for_next_week
    #week = Time.now.next_week
    week = Time.now + 2.week 
    Rails.logger.debug "week"
    Event.where(start_date:week.beginning_of_week..week.end_of_week, event_type:[1,3,4])
  end

  def self.for_slack
    events = Event.for_next_week

    msg_news_letter = ""
    msg_cleaner = ""
    slack_msg = ""

    events.each do |event|
      msg_news_letter += "#{event.name}\n #{event.description}\n#{event.start_date} #{event.start_time.strftime("%H:%M")} - #{event.end_time.strftime("%H:%M")}\n"
      msg_cleaner += "#{event.start_date.strftime("%a")} after #{event.end_time.ago(30.minutes).strftime("%H:%M")}\n"
      slack_msg = {news_letter:msg_news_letter, msg_clearner:msg_cleaner}
      slack_msg.to_json
      Rails.logger.debug slack_msg.to_json
    end
    slack_msg
  end


  def header
    case event_type
      when 1 
        "EVENT: #{start_date.strftime("%b %e")}"
      when 2
        "POPUP: #{start_date.strftime("%b %e")} to #{end_date.strftime("%b %e")}"
      when 3 
        "HAPPY HOUR: #{start_date.strftime("%b %e")}"
      when 4
        "PARTY: #{start_date.strftime("%b %e")}"
      when 5
        "NEW TENANT"
    end
  end

  def space_time
    case event_type
      when 1 
        "From #{start_time.strftime("%H:%M")} - #{end_time.strftime("%H:%M")} @ #{space}"
      when 3 
        "From #{start_time.strftime("%H:%M")} - #{end_time.strftime("%H:%M")} @ #{space}"
      when 4
        "From #{start_time.strftime("%H:%M")} - #{end_time.strftime("%H:%M")} @ #{space}"
    end
  end
end
