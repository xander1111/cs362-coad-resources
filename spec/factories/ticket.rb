FactoryBot.define do

  factory :ticket do
    sequence(:name) { |n| "Ticket ##{n}" }
    sequence(:phone) { |n| "+1 555 555 #{1000 + n}" }
    
  end

end
