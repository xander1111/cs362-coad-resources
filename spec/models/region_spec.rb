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

end
