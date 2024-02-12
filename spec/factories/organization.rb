FactoryBot.define do

  factory :organization do
    sequence(:email) { |n| "example_org-#{n}@example.com" }
    sequence(:name) { |n| "org ##{n}" }
    sequence(:phone) { |n| "+1 555 555 #{1000 + n}" }
    sequence(:secondary_phone) { |n| "+1 555 555 #{2000 + n}" }

    status { 0 }

    sequence(:primary_name) { |n| "primary #{n}" }
    sequence(:secondary_name) { |n| "secondary #{n}" }
  end

end
