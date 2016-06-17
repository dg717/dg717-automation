module API
  module V1
    class Events < Grape::API
      include API::V1::Defaults

      resource :events do 
        desc "Return events next week"
        get "", root: :events do 
          Event.for_slack
        end
      end
    end
  end
end