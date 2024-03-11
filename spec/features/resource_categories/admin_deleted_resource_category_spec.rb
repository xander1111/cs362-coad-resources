require 'rails_helper'

RSpec.describe 'Deleting a Resource Category', type: :feature do

  before(:each) {
    @user = create(:user, role: :admin)
    log_in_as(@user)

    @category_name = "Test Category for e2e"
    @category = create(:resource_category, name: @category_name)
  }

  it "can delete a category from the home screen" do

    visit root_path

    click_on "Categories"
    click_on @category_name

    click_on "Delete"

    expect(current_path).to eq resource_categories_path

  end

end
