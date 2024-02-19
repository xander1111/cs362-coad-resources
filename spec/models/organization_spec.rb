require 'rails_helper'

RSpec.describe Organization, type: :model do

  it "has a name" do
      org = build_stubbed(:organization)
    expect(org).to respond_to(:name)
  end

end
