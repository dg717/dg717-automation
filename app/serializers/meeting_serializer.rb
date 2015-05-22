class MeetingSerializer < ActiveModel::Serializer
  attributes :id, :name, :start_time, :end_time, :display_start, :display_end, :is_now, :is_tomorrow
  has_one :user
end
