FactoryBot.define do

  factory :user do
    sequence(:email) { |n| "example_user-#{n}@example.com" }
    password { "User_password" }

    before(:create) { |user| user.skip_confirmation! }

  end

end
