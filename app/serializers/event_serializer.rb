class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :from, :to, :type, :description, :subtext, :image
end
