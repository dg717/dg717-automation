module API
  module V1
    class Meetings < Grape::API
      include API::V1::Defaults

      resource :meetings do 
        desc "Return all meetings"
        get "", root: :meetings do 
          Meeting.all
        end

        desc  "Return meetings for specific meeting room"
        params do 
          requires :id, type: Integer, desc: ""
        end
        get ":id", root: :meetings do 
          Meeting.where(id: permitted_params[:id])
        end
      end
    end
  end
end