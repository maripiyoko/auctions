FactoryGirl.define do
  factory :auction do
    name { Faker::Lorem::sentence }
    description { Faker::Lorem::paragraph }
    association :user
    association :product
    min_price { Faker::Number::number(4) }
    deadline_date { Faker::Date::between(2.days.ago, Date.today) }
  end

end
