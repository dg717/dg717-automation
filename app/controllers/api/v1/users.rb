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
        #Take parameters from Zapier and return 201 if user is created.
        post "", root: :users do 
          
        end 
      end
    end
  end
end