FactoryBot.define do

  factory :user do
    email
    password { "User_password" }
    
    before(:create) { |user| user.skip_confirmation! }

  end

end
