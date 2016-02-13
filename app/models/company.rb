class Company < ActiveRecord::Base
  has_many :users
  has_one :tracking, dependent: :destroy
  has_many :meetings, through: :users
  belongs_to :user
  has_many :locker_keys

  delegate :last_sent, to: :tracking
  delegate :last_total, to: :tracking

  accepts_nested_attributes_for :users, allow_destroy: true
  accepts_nested_attributes_for :locker_keys, allow_destroy: true

  mount_uploader :logo, CompanyLogoUploader
  #Company_type : 0 == normal, 1 == scrum, 2 == portfolio, 3 == old, 4 == other
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

  def scrum?
    true if self.company_type == 1
  end

  def total_rent
    #Look at start_date and figure out the difference?
    case self.company_type 
      when 0 
        800 * full_timer + 400 * part_timer
      when 1
        0
      when 2
        500 * full_timer + 200 * part_timer
      when 3 
        750 * full_timer + 375 * part_timer
      when 4 
        self.special_price
      else
        0
    end
  end

  def full_timer
    self.users.where(desk_type:0).count
  end

  def part_timer
    total = self.users.where(desk_type:1).count
    if self.company_type == 2
      total-2 >= 0 ? total-2 : 0 
    else 
      total
    end
  end

  def send_email?
    if self.last_sent.nil?
      puts "calling create_tracking"
      self.create_tracking
    end
    puts "after if"
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