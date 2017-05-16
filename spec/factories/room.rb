FactoryGirl.define do
  factory :room do
    sequence(:name) { |n| "translation#{n}" }
    sequence(:slug) { |n| "translation#{n}" }
  end
end