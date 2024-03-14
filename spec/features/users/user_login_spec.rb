require 'rails_helper'

RSpec.describe 'Logging in', type: :feature do

  before(:each) {
    @user = create(:user)
  }

  it "can log in from the home page" do

    visit root_path

    click_on "Log in"

    fill_in "Email address", with: @user.email
    fill_in "Password", with: @user.password

    click_on "Sign in"

    expect(current_path).to eq(dashboard_path)

  end

end
