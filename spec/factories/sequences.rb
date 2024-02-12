FactoryBot.define do

  sequence :email do |n|
    "person#{n}@example.com"
  end

  sequence :name do |n|
    "Name #{n}"
  end

  sequence :phone do |n|
    "+1 555 555 #{1000 + n}"
  end

end
