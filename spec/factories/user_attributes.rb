FactoryGirl.define do
  factory :user_attribute, :class => 'UserAttributes' do
    user_id 1
interest "MyText"
favorite_color "MyString"
title "MyString"
  end

end
