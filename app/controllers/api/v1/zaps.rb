module API
  module V1
    class Zaps < Grape::API
      include API::V1::Defaults

      resource :zaps do 
        desc "Return events next week"
        get "events" do
          events = Event.for_slack
        end
      end
    end
  end
end