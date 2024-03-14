require 'rails_helper'

RSpec.describe 'Creating an Organization Application', type: :feature do

  before(:each) {
    @user = create(:user)
    log_in_as(@user)

    @admin = create(:user, role: :admin, email: "admin_user@example.com")

    @res_cat1 = create(:resource_category, name: "Category 1")
    @res_cat2 = create(:resource_category, name: "Category 2")

    @org_name = "Test Org for creation"
  }

  it "can create an organization from the home page" do

    visit root_path

    click_on "Dashboard"
    click_on "Create Application"

    choose "organization_liability_insurance_true"
    choose "organization_agreement_one_true"
    choose "organization_agreement_two_true"
    choose "organization_agreement_three_true"
    choose "organization_agreement_four_true"
    choose "organization_agreement_five_true"
    choose "organization_agreement_six_true"
    choose "organization_agreement_seven_true"
    choose "organization_agreement_eight_true"

    fill_in "organization_primary_name", with: "Primary name"
    fill_in "organization_name", with: @org_name
    fill_in "organization_phone", with: "555 555 5555"
    fill_in "organization_secondary_name", with: "Secondary name"
    fill_in "organization_secondary_phone", with: "555 555 5556"
    fill_in "organization_email", with: "org_test@example.com"
    check("organization_resource_category_ids_#{@res_cat1.id}")
    fill_in "organization_description", with: "Test description"
    choose "organization_transportation_yes"

    click_on "Apply"

    expect(current_path).to eq organization_application_submitted_path

  end

end
