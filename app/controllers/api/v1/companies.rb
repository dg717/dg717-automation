require "grape-swagger"

module API
  module V1
    class Companies < Grape::API
      include API::V1::Defaults

      resource :companies do 
        desc "Return all companies"
        get "", root: :companies do 
          Company.all 
        end
      end
    end
  end
end