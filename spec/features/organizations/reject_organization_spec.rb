require 'rails_helper'

RSpec.describe 'Rejecting an organization', type: :feature do

  before(:each) {
    @user = create(:user, role: :admin)
    log_in_as(@user)

    @org_name = "Test Org for approval"
    @org = create(:organization, name: @org_name, status: :submitted)
  }

  it "can reject an organization from the home page" do

    visit root_path

    click_on "Organizations"
    click_on "Pending"
    click_on @org_name

    fill_in "Rejection Reason", with: "Test reason"
    click_on "Reject"

    expect(current_path).to eq organizations_path

    click_on "Rejected"

    expect(page).to have_selector("#organization_#{@org.id}")

  end

end
