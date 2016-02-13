class User < ActiveRecord::Base
  has_many :meetings
  belongs_to :company
  has_one :user_attributes
  has_many :card_key
  has_one :external_service

  accepts_nested_attributes_for :user_attributes, allow_destroy: true
  accepts_nested_attributes_for :card_key, allow_destroy: true
  accepts_nested_attributes_for :external_service, allow_destroy: true

  delegate :company_name, to: :company
  mount_uploader :avatar, AvatarUploader

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
