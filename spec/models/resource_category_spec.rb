require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do

  let (:res_cat) { build_stubbed(:resource_category) }

  describe "attribute specs" do

    it "has a name" do
      expect(res_cat).to respond_to(:name)
    end

    it "has an active status" do
      expect(res_cat).to respond_to(:active)
    end

  end

  describe "relation specs" do

    it { should have_and_belong_to_many(:organizations) }
    it { should have_many(:tickets) }

  end

  describe "attribute validation specs" do

    it { should validate_presence_of(:name) }

    it { should validate_length_of(:name).is_at_least(1).is_at_most(255) }

    it { should validate_uniqueness_of(:name).case_insensitive }

  end

  describe "member function specs" do

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

  end

  describe "class function specs" do
    it "can provide a 'unspecified' category" do
      expect(ResourceCategory.unspecified.name).to eq("Unspecified")
    end
  end

  describe "database tests" do

    let (:active_res_cat) { create(:resource_category, active: true) }
    let (:inactive_res_cat) { create(:resource_category, active: false) }

    it "can activate itself" do
      active_res_cat.activate
      expect(active_res_cat).to be_active
    end
  
    it "can deactivate itself" do
      active_res_cat.deactivate
      expect(active_res_cat).to_not be_active
    end
    
    it "can provide a list of active resource categories" do
      expect(ResourceCategory.active).to contain_exactly(active_res_cat)
    end

    it "can provide a list of inactive resource categories" do
      expect(ResourceCategory.inactive).to contain_exactly(inactive_res_cat)
    end

  end

end
