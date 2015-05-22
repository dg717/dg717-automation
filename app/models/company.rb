class Company < ActiveRecord::Base
  has_many :users
  has_many :meetings, through: :users
  belongs_to :admin, class_name: "User", foreign_key: "user_id"

  #TODO: Put the constant outside
  LIMIT_PER_USER = 6

  alias_attribute :company_name, :name

  def monthly_usage 
    #Company's monthly usage in hours
    self.meetings.total/3600
  end

  def monthly_allowance
    (self.users.virtual.count * VIRTUAL_HOURS) + (self.users.dedicated.count * DEDICATED_HOURS) 
  end

  #return true if the monthly allowance have passed
  def near_limit?
    true if self.monthly_usage > (self.monthly_allowance * 0.8)
  end

  def over_usage?
    true if self.monthly_usage > self.monthly_allowance
  end

  def chargeable?
    true if self.chargeable
  end

end