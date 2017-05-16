FactoryGirl.define do
  factory :message do
    association :user
    association :room
    content "MyText"
  end
end