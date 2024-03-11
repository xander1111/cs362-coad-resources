require 'rails_helper'

RSpec.describe 'Creating a Region', type: :feature do

  before(:each) {
    @user = create(:user, role: :admin)
    log_in_as(@user)
  }

  it "can create a new region from the home screen" do

    visit root_path

    click_on "Regions"
    click_on "Add Region"

    fill_in "Name", with: "Feature test region"
    click_on "Add Region"

    expect(current_path).to eq regions_path

  end

end
