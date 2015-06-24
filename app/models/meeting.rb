class Meeting < ActiveRecord::Base
  belongs_to :room
  belongs_to :user

  TIMEZONE = "Pacific Time (US & Canada)"
  #Scope.. 
  default_scope { order('start_time') }

  scope :for_room, -> { 
            where("end_time >= '#{self.time_now}' and start_time <= '#{Time.now.in_time_zone(TIMEZONE).end_of_day}' and delete_flag = false") 
          }
  scope :is_ongoing, ->{  
            where("start_time < '#{self.time_now}' and end_time > '#{self.time_now}'")
          }

  scope :total, -> {
            where("extract(month from now()) = extract(month from start_time) and extract(year from now()) = extract(year from start_time)")
            .sum("extract(epoch from end_time - start_time)")
          }
  scope :dd, -> {
            where("")
  }

  #Return if the meeting is currently on-gogin or not. Returns true or false

  def is_now
    start_time < Meeting.time_is_now and Meeting.time_is_now < end_time
  end
  
  #Return if the meeting is held tomorrow. 
  def is_tomorrow
    start_time.to_date == Date.tomorrow
  end
  
  #Format the start time of the meeting to be displayed.
  def display_start
    #start_time.in_time_zone(TIMEZONE).strftime("%H:%M")
    start_time.strftime("%H:%M")
   end

  #Format the end time of the meeting to be displayed.  
  def display_end
    #end_time.in_time_zone(TIMEZONE).strftime("%H:%M")
    end_time.strftime("%H:%M")
  end

  def length
    end_time - start_time
  end

  def flag_deleted
    self.deleted = true
    self.save
  end

  def self.time_now 
    Time.now.in_time_zone(TIMEZONE)
  end 

  def self.time_is_now
    offset = Meeting.time_now.utc_offset/3600
    Time.now.in_time_zone(TIMEZONE) + offset.hours
  end


end