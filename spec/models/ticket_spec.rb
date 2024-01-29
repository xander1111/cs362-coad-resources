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

end
