FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet::email(name) }
    password 'secret123'
    password_confirmation 'secret123'
  end

end
