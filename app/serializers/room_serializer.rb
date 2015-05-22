class RoomSerializer < ActiveModel::Serializer
  attributes :id, :name, :is_occupied
  has_many :meetings
end

