FactoryGirl.define do
  factory :user do 
    sequence(:name) { |n| "translation#{n}" }
  end
end