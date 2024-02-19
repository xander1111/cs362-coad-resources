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
