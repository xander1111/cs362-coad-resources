require 'rails_helper'

RSpec.describe 'User registration', type: :feature do

  it "can create a new account from the home page" do

    visit root_path

    click_on "Sign up"

    fill_in "Email address", with: "test_email@example.com"
    fill_in "Password", with: "Test_Password"
    fill_in "Password confirmation", with: "Test_Password"

    click_on "commit"

    expect(current_path).to eq(root_path)
    expect(page).to have_text("confirmation link")

  end

end
