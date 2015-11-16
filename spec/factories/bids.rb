FactoryGirl.define do
  factory :bid do
    association :user
    association :auction
    price 1000
  end

end
