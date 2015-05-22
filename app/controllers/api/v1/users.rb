require "grape-swagger"

module API
  module V1
    class Users < Grape::API
      include API::V1::Defaults

      resource :users do 
        desc "Return all users"
        get "", root: :users do 
          Company.all 
        end
      end
    end
  end
end