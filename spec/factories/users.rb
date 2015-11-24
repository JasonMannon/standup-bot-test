FactoryGirl.define do
  factory :user do
    slack_id   { Faker::Number.number(10) }
    full_name { Faker::Name.name }
  end
end
