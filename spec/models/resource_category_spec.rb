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

  it { should validate_presence_of(:name) }

  it { should validate_length_of(:name).is_at_least(1).is_at_most(255) }
  
  it { should validate_uniqueness_of(:name).case_insensitive }

  it "can activate itself" do
    @res_cat = create(:resource_category)
    @res_cat.activate
    expect(@res_cat).to be_active
  end

end
