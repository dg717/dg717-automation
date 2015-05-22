module API
  module V1
    class Rooms < Grape::API
      include API::V1::Defaults

      resource :rooms do 
        desc "Return all rooms"
        get "", root: :rooms, each_serializer: RoomsSerializer do 
          Room.all
        end

        desc "Return a room with associated meeetings"
        params do 
          requires :id, type: Integer, desc: "ID of the room"
        end
        get ":id", root: :rooms do 
          Room.where(id: permitted_params[:id])
        end 
      end
    end
  end
end