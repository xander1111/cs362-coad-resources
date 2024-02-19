require 'rails_helper'

RSpec.describe Organization, type: :model do

  let (:org) { build_stubbed(:organization) }

  it "has a name" do
    expect(org).to respond_to(:name)
  end

  it "has a status" do
    expect(org).to respond_to(:status)
  end

end
