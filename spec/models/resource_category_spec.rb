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

  it "can tell if it's inactive" do
    res_cat.active = false
    expect(res_cat.inactive?).to be_truthy
  end

  it "can tell if it's active" do
    res_cat.active = true
    expect(res_cat.inactive?).to be_falsy
  end

  it "has a string reppresentation that is its name" do
    @name = "test name"
    @res_cat = build_stubbed(:resource_category, name: @name)
    expect(@res_cat.to_s).to eq(@name)
  end

  it "can provide a 'unspecified' category" do
    expect(ResourceCategory.unspecified.name).to eq("Unspecified")
  end

  describe "database tests" do

    let (:res_cat_db) { create(:resource_category) }

    it "can activate itself" do
      res_cat_db.activate
      expect(res_cat_db).to be_active
    end
  
    it "can deactivate itself" do
      res_cat_db.deactivate
      expect(res_cat_db).to_not be_active
    end

  end

end
