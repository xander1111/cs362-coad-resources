require 'rails_helper'

RSpec.describe 'Updating an Organization', type: :feature do

  before(:each) {
    @org = create(:organization, status: :approved, description: "Description")

    @user = create(:user, organization: @org)
    log_in_as(@user)

    @admin = create(:user, role: :admin, email: "admin_user@example.com")

    @res_cat1 = create(:resource_category, name: "Category 1")
    @res_cat2 = create(:resource_category, name: "Category 2")
  }

  it "can update an organization from the home page" do

    @new_description = "New description"

    visit root_path

    click_on "Dashboard"
    click_on "Edit Organization"

    fill_in "Description", with: @new_description

    click_on "Update Resource"

    expect(current_path).to eq organization_path(id: @org.id)
    expect(page).to have_text(@new_description)

  end

end
