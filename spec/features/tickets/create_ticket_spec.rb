require 'rails_helper'

RSpec.describe 'Creating a Ticket', type: :feature do

  before(:each) {
    @user = create(:user)
    log_in_as(@user)

    @region_name = "test region"
    @region = create(:region, name: @region_name)

    @category_name = "test category"
    @res_cat = create(:resource_category, name: @category_name)

    @ticket_name = "Test ticket name"
  }

  it "can create a ticket from the home page" do

    visit root_path

    click_on "Get Help"

    fill_in "Full Name", with: @ticket_name
    fill_in "Phone Number", with: "+1 555 555 5555"
    select(@region_name, from: "Region") 
    select(@category_name, from: "Resource Category")
    fill_in "Description", with: "Test description"

    click_on "Send this help request"

    expect(current_path).to eq(ticket_submitted_path)

  end

end
