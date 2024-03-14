require 'rails_helper'

RSpec.describe 'Releasing a ticket by an', type: :feature do

 before(:each) {
    @org_name = "Test organization"
    @org = create(:organization, status: :approved, name: @org_name, description: "Description")

    @user = create(:user, organization: @org)
    log_in_as(@user)

    @region = create(:region, name: "test region")
    @res_cat = create(:resource_category, name: "test category")

    @ticket_name = "Test ticket name"
    @ticket = create(:ticket, name: @ticket_name, region: @region, resource_category: @res_cat, organization: @org)
  }

  it "can release a ticket from the home page" do
    
    visit root_path

    click_on "Dashboard"
    click_on "Tickets"
    click_on @ticket_name

    click_on "Release"

    expect(current_path).to eq(dashboard_path)

    click_on "Tickets"
    click_on @ticket_name

    expect(page).to_not have_text(@org_name)

  end

end
