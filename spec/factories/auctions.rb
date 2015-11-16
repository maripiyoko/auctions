FactoryGirl.define do
  factory :auction do
    name { Faker::Lorem::sentence }
    description { Faker::Lorem::paragraph }
    association :user
    association :product
    min_price 100
    deadline_date { Faker::Date::between(Date.today, Date.tomorrow.noon) }
  end

end
