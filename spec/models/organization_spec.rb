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

end
