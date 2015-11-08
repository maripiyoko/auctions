FactoryGirl.define do
  factory :product do
    name { Faker::Lorem::characters(30) }
    description { Faker::Lorem::paragraph }
    association :user
  end

end
