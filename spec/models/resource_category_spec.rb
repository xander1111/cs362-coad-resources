require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do

  let (:res_cat) { build_stubbed(:resource_category) }

  it "has a name" do
    expect(res_cat).to respond_to(:name)
  end

  it "has an active status" do
    expect(res_cat).to respond_to(:active)
  end

  it { should have_and_belong_to_many(:organizations) }
  it { should have_many(:tickets) }

end
