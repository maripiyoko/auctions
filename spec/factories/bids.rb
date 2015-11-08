FactoryGirl.define do
  factory :bid do
    association :user
    association :auction
    price { Faker::Number.number(4) }
  end

end
