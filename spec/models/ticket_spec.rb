require 'rails_helper'

RSpec.describe Ticket, type: :model do

  let (:ticket) { build_stubbed(:ticket) }

  it "has a name" do
    expect(ticket).to respond_to(:name)
  end

  it "has a description" do
    expect(ticket).to respond_to(:description)
  end

  it "has a phone number" do
    expect(ticket).to respond_to(:phone)
  end

  it "has an organization id" do
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

  it "can tell if there is no responsible organization" do
    expect(ticket).to_not be_captured
  end

  it "can tell if there is a responsible organization" do
    ticket.organization = build_stubbed(:organization)
    expect(ticket).to be_captured
  end

  it "has a string representation that contains it's ID" do
    ticket.id = 1
    expect(ticket.to_s).to eq("Ticket 1")
  end

  describe "database tests" do

    let (:reg1) { build_stubbed(:region) }
    let (:reg2) { build_stubbed(:region) }
    let (:resource_cat1) { build_stubbed(:resource_category) }
    let (:resource_cat2) { build_stubbed(:resource_category) }
    let (:org) { build_stubbed(:organization) }
    let (:open_ticket) { create(:ticket, closed: false, region: reg1, resource_category: resource_cat1) }
    let (:closed_ticket) { create(:ticket, closed: true, region: reg1, resource_category: resource_cat2) }
    let (:open_ticket_with_org) { create(:ticket, closed: false, region: reg2, resource_category: resource_cat1, organization: org) }
    let (:closed_ticket_with_org) { create(:ticket, closed: true, region: reg2, resource_category: resource_cat2, organization: org) }


    it "can provide a list of all open tickets" do
      expect(Ticket.open).to contain_exactly(open_ticket)
    end
  
    it "can provide a list of all closed tickets" do
      expect(Ticket.closed).to contain_exactly(closed_ticket, closed_ticket_with_org)
    end

    it "can provide a list of all open tickets with an assigned organization" do
      expect(Ticket.all_organization).to contain_exactly(open_ticket_with_org)
    end

    it "can find all open tickets with a specified organization" do
      expect(Ticket.organization(org.id)).to contain_exactly(open_ticket_with_org)
    end

    it "can find all closed tickets with a specified organization" do
      expect(Ticket.closed_organization(org.id)).to contain_exactly(closed_ticket_with_org)
    end

    it "can find all tickets with a specified region" do
      expect(Ticket.region(reg1.id)).to contain_exactly(open_ticket, closed_ticket)
    end

    it "can find all tickets with a specified resource category" do
      expect(Ticket.resource_category(resource_cat1.id)).to contain_exactly(open_ticket, open_ticket_with_org)
    end

  end

end
