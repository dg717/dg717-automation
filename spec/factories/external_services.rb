FactoryGirl.define do
  factory :external_service, :class => 'ExternalServices' do
    user_id 1
envoy_status 1
yaroom_status 1
google_status 1
meraki_status 1
  end

end
