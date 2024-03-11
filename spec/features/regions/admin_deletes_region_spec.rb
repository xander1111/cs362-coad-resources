require 'rails_helper'

RSpec.describe 'Deleting a Region', type: :feature do

  before(:each) {
    @user = create(:user, role: :admin)
    log_in_as(@user)

    @region_name = "Test Region for e2e"
    @region = create(:region, name: @region_name)
  }

  it "can delete a new region from the home screen" do

    visit root_path

    click_on "Regions"
    click_on @region_name

    click_on "Delete"

    expect(current_path).to eq regions_path

  end

end
