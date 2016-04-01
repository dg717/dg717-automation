class EventSerializer < ActiveModel::Serializer
  attributes :name, :start_date, :start_time, :end_date, :end_time, :description
end
