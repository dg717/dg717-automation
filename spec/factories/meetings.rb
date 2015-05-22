FactoryGirl.define do
  factory :meeting, :class => 'Meetings' do
    user_id 1
room_id 1
modified_by 1
name "MyString"
description "MyText"
start_time "2015-01-16 21:33:22"
end_time "2015-01-16 21:33:22"
length 1
  end

end
