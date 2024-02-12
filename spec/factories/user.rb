FactoryBot.define do

  factory :user do
    sequence(:email) { |n| "example_user-#{n}@example.com" }
    password { "User_password" }
  end

end
