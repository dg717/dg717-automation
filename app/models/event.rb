class Event < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  default_scope -> {where(["start_date >= ?",Date.today]).order("start_date")}
  #type ["Event",1],["Popup",2],["Happy Hour",3],["Party",4],["NewTenant",5]]

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
