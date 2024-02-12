FactoryBot.define do

  factory :resource_category do
    sequence(:name) { |n| "category ##{n}" }
  end

end
