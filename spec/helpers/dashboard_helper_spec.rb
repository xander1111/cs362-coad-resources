require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the DashboardHelper. For example:
#
# describe DashboardHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe DashboardHelper, type: :helper do

  describe "dashboard_for" do

    it "returns the admin dashboard for a admin user" do
      @user = build_stubbed(:user, role: :admin)
      expect(helper.dashboard_for(@user)).to eq("admin_dashboard")
    end

    it "returns the organization submitted dashboard for a user in a submitted organization" do
      @user = build_stubbed(:user, organization: build_stubbed(:organization, status: :submitted))
      expect(helper.dashboard_for(@user)).to eq("organization_submitted_dashboard")
    end

    it "returns the organization approved dashboard for a user in an approved organization" do
      @user = build_stubbed(:user, organization: build_stubbed(:organization, status: :approved))
      expect(helper.dashboard_for(@user)).to eq("organization_approved_dashboard")
    end

    it "returns the create application dashboard for a user with no organization" do
      @user = build_stubbed(:user)
      expect(helper.dashboard_for(@user)).to eq("create_application_dashboard")
    end

  end

end
