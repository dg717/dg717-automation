class Company < ActiveRecord::Base
  has_many :users
  has_one :tracking, dependent: :destroy
  has_many :meetings, through: :users
  belongs_to :admin, class_name: "User", foreign_key: "user_id"

  delegate :last_sent, to: :tracking
  delegate :last_total, to: :tracking

  #TODO: Put the constant outside
  LIMIT_PER_USER = 6

  after_create :create_tracking

  alias_attribute :company_name, :name

  def monthly_usage 
    #Company's monthly usage in hours
    (self.meetings.total/3600).round
  end

  def monthly_allowance
    (self.users.virtual.count * VIRTUAL_HOURS) + (self.users.dedicated.count * DEDICATED_HOURS) 
  end

  def excess_usage 
    #Company's monthly usage in hours
    self.monthly_usage - self.monthly_allowance
  end

  #return true if the monthly allowance have passed
  def near_limit?
    true if self.monthly_usage > (self.monthly_allowance * 0.9)
  end

  def over_usage?
    true if self.monthly_usage > self.monthly_allowance
  end

  def chargeable?
    true if self.chargeable
  end

  def send_email?
    (self.monthly_usage.to_i > self.last_total.to_i && self.last_sent < 2.days.ago) ? true : false
  end

  def mail_sent
    self.tracking.last_sent = Time.now
    self.tracking.save
  end

  private
  def create_tracking
    t = Tracking.new(company_id: self.id)
    t.last_sent = Time.now
    t.save
  end
end