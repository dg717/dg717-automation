require 'httparty'
class Yaroomer
  include HTTParty
  base_uri 'https://api.yarooms.com'
  #debug_output 

  @token = nil
  @@location = 12676
  @@email = "schubert-shida@garage.co.jp"
  @@password = "yar08shmake03"
  @@subdomain = "newcontext"

  def initialize
    response = self.authorize
    self.valid_response?(response) ? @token = response["data"]["token"] : self.handle_failure(response)
  end

  #Get rooms and register them.. Run once. 
  def get_rooms
    response = self.class.get('/rooms', headers: {"X-TOKEN" => @token})
    #Need to refactor the error handling
    self.valid_response?(response) ? self.save_rooms(response) : self.handle_failure(response)
  end

  def save_rooms(response)
    response["data"]["list"].each do |data|
      unless Room.find_by_id(data["id"])
        Room.create!(name:data["name"],capacity:data["capacity"],id:data["id"])
      end
    end
  end

  #Get accounts and register those that aren't registered. Run every 3hrs.
  def get_accounts 
    response = self.class.get('/accounts', headers: {"X-TOKEN" => @token}, query: {"perPage" => 300})
    self.valid_response?(response) ? self.save_accounts(response) : self.handle_failure(response)
  end

  def save_accounts(response)
    response["data"]["list"].each do |data|
      unless User.find_by_id(data["id"])
        User.create!(id:data["id"],first_name:data["first_name"],last_name: data["last_name"], email:data["email"],yaroom_id:data["id"],company_id:self.get_set_company(data["email"]))
      end
    end    
  end


  #Get the current meeting rooms. Run every 5 mins.
  def get_all_meetings
    start_date = (Date.today-30).strftime("%F")
    end_date = (Date.today+29).strftime("%F")
    interval = "#{start_date}..#{end_date}" 
    puts interval
    response = self.class.get('/meetings', headers: {"X-TOKEN" => @token}, query: {"scope[where]" => "location:#{@@location}","scope[when]" => "interval:#{interval}","perPage" => 1000})
    self.valid_response?(response) ? self.save_meetings(response) : self.handle_failure(response)
  end

  #Get the current meeting rooms. Run every 5 mins.
  def get_meetings
    start_date = (Date.today-1).strftime("%F")
    end_date = (Date.today+29).strftime("%F")
    interval = "#{start_date}..#{end_date}" 
    puts interval
    response = self.class.get('/meetings', headers: {"X-TOKEN" => @token}, query: {"scope[where]" => "location:#{@@location}","scope[when]" => "interval:#{interval}","perPage" => 1000})
    self.valid_response?(response) ? self.save_meetings(response) : self.handle_failure(response)
  end

  def save_meetings(response)
    response["data"]["list"].each do |data|
      if meeting = Meeting.unscoped.find_by_id(data["id"])
        if meeting.yaroom_updated_at != data["update_at"]
          meeting.update_attributes(start_time: data["start"], end_time: data["end"], name: data["name"], yaroom_updated_at: data["updated_at"],room_id:data["room_id"])
        end
      else
        Meeting.create!(id:data["id"], start_time: data["start"], end_time: data["end"], name: data["name"], yaroom_updated_at: data["updated_at"],yaroom_id:data["id"],description:data["description"],user_id:data["account_id"],room_id:data["room_id"])
      end
    end    
  end

  def check_deleted_meetings
    Meeting.where("start_time > ?", 4.hour.from_now).each do |meeting|
      respnse = self.class.get('/meetings/#{meeting_id}', headers: {"X-TOKEN" => @token})
      self.valid_response?(response) ? self.update_meetings(meeting, response) : self.handle_failure(response)
      #TODO: Check to see if the meeting was deleted within last 2 days.
    end
  end

  def update_meetings(meeting, response)
    #if the meeting is deleted within 4 hours then 
    if response["data"]["list"].blank?
      meeting.flag_deleted = true
      meeting.save
    end
  end

  def get_set_company(name)
    domain = name.split('@')[1].split('.')[0].downcase
    Rails.logger.debug(domain)
    if domain and company = Company.find_by_domain(domain)
      company.id
    else 
      company = Company.create!(domain:domain)
      company.id
    end
  end

  def authorize
    puts "location is #{@@location}"
    self.class.post('/auth',
      body: {
        email: @@email,
        password: @@password,
        subdomain: @@subdomain
      }
    )
  end

  def valid_response?(response)
    response["status"] == 1 ? true : false
  end

  def handle_failure(response)
    if response["error"] == "Invalid login credentials"
      Rails.logger.error("error login")
    else 
      #Output the log of where the error was called.
      Rails.logger.error("error in #{caller[0]}")
    end
  end
end