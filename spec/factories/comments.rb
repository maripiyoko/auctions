FactoryGirl.define do
  factory :comment do
    association :user
    association :bid
    evaluation "普通"
    comment { Faker::Lorem::paragraph }
  end

end
