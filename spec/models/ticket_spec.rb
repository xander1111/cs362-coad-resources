require 'rails_helper'

RSpec.describe Ticket, type: :model do

  let (:ticket) { Ticket.new }

  it "has a name" do
    expect(ticket).to respond_to(:name)
  end

  it "has a description" do
    expect(ticket).to respond_to(:description)
  end

  it "has a phone number" do
    expect(ticket).to respond_to(:phone)
  end

  it "has an orginization id" do
    expect(ticket).to respond_to(:organization_id)
  end

  it "has a closed status" do
    expect(ticket).to respond_to(:closed)
  end

  it "has a closed at datetime" do
    expect(ticket).to respond_to(:closed_at)
  end

  it "has a resource category id" do
    expect(ticket).to respond_to(:resource_category_id)
  end

  it "has a region id" do
    expect(ticket).to respond_to(:region_id)
  end

  it { should belong_to(:region) }
  it { should belong_to(:resource_category) }
  it { should belong_to(:organization).optional }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:phone) }
  it { should validate_presence_of(:region_id) }
  it { should validate_presence_of(:resource_category_id) }

  it { should validate_length_of(:name).is_at_least(1).is_at_most(255) }
  it { should validate_length_of(:description).is_at_most(1020) }

  it { should allow_value("+1 555 555 5555").for(:phone) }
  it { should_not allow_value("not a phone number").for(:phone) }

  it "can tell when it's open" do
    expect(ticket).to be_open
  end

  it "can tell when it's closed" do
    ticket.closed = true
    expect(ticket).to_not be_open
  end

  it "can tell if there is no responsible orginization" do
    expect(ticket).to_not be_captured
  end

  it "can tell if there is a responsible orginization" do
    ticket.organization = Organization.new()
    expect(ticket).to be_captured
  end

  it "has a string representation that contains it's ID" do
    ticket.id = 1
    expect(ticket.to_s).to eq("Ticket 1")
  end

end
