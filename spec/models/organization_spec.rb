require 'rails_helper'

RSpec.describe Organization, type: :model do

  let (:org) { build_stubbed(:organization) }

  it "has a name" do
    expect(org).to respond_to(:name)
  end

  it "has a status" do
    expect(org).to respond_to(:status)
  end

  it "has a phone number" do
    expect(org).to respond_to(:phone)
  end

  it "has an email" do
    expect(org).to respond_to(:email)
  end

  it "has a description" do
    expect(org).to respond_to(:description)
  end

  it "has a rejection reason" do
    expect(org).to respond_to(:rejection_reason)
  end

  it "has a liability insurance flag" do
    expect(org).to respond_to(:liability_insurance)
  end

  it "has a primary name" do
    expect(org).to respond_to(:primary_name)
  end

  it "has a secondary name" do
    expect(org).to respond_to(:secondary_name)
  end

  it "has a title" do
    expect(org).to respond_to(:title)
  end

  it "has a transportation status" do
    expect(org).to respond_to(:transportation)
  end

  it { should have_many(:users) }
  it { should have_many(:tickets) }
  it { should have_and_belong_to_many(:resource_categories) }

end
