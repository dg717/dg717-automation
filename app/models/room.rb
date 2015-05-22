class Room < ActiveRecord::Base
 has_many :meetings, -> {for_room}

 def is_occupied
    !self.meetings.is_ongoing.blank?
 end

end