FactoryBot.define do

  factory :organization do
    email
    name
    phone
    secondary_phone { generate(:phone) }

    status { :submitted }

    primary_name { generate(:name) }
    secondary_name { generate(:name) }
  end

end
