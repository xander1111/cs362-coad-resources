require 'rails_helper'

RSpec.describe Region, type: :model do

  let (:region) { Region.new }

  it "has a name" do
    expect(region).to respond_to(:name)
  end

  it "has a string representation that is its name" do
    name = 'Mt. Hood'
    region2 = Region.new(name: name)
    result = region2.to_s
  end

  it { should have_many(:tickets) }

  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_least(1).is_at_most(255) }
  it { should validate_uniqueness_of(:name).case_insensitive }

end
