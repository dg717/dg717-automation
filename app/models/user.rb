class User < ActiveRecord::Base
  has_many :meetings
  belongs_to :company

  delegate :company_name, to: :company

  #dedicated desk users
  scope :dedicated, -> {where("desk_type = 0")}

  #virutal desk users
  scope :virtual, -> {where("desk_type = 1")}

  def user_name
    "#{self.first_name} #{self.last_name}"
  end

  def membership
    self.desk_type == 0 ? "dedicated" : "virtual"
  end

  def available_hours
    (self.limited_hours - self.meetings.total/3600).to_i.round
  end

  def limited_hours
    eval((self.membership + "_hours").upcase)
  end

  def used_hours
    (self.meetings.total/3600).to_i.round
  end

  def excess_usage
    available_hours * -1
  end

end
