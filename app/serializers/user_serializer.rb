class UserSerializer < ActiveModel::Serializer
  #cached
  #delegate :cache_key, to: :object
  attributes :id, :first_name, :last_name, :company_name
end
