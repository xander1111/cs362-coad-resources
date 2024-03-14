require 'rails_helper'

RSpec.describe 'Deleting a Ticket', type: :feature do

  before(:each) {
    @user = create(:user, role: :admin)
    log_in_as(@user)

    @region = create(:region, name: "test region")
    @res_cat = create(:resource_category, name: "test category")

    @ticket_name = "Test ticket name"
    @ticket = create(:ticket, name: @ticket_name, region: @region, resource_category: @res_cat)
  }

  it "can delete a ticket from the home page" do

    visit root_path

    click_on "Dashboard"
    click_on @ticket_name

    click_on "Delete"

    expect(current_path).to eq(dashboard_path)
    expect(page).not_to have_selector("#ticket_#{@ticket.id}")

  end

end
