require 'rails_helper'

RSpec.describe DashboardHelper, type: :helper do

  describe "dashboard_for" do

    it "returns the admin dashboard for a admin user" do
      @user = double(:user, admin?: true)
      # @user = build_stubbed(:user, role: :admin)

      expect(helper.dashboard_for(@user)).to eq("admin_dashboard")
    end

    it "returns the organization submitted dashboard for a user in a submitted organization" do
      @user = double(:user, admin?: false)
      allow(@user).to receive_message_chain("organization.submitted?": true)
      # @user = build_stubbed(:user, organization: build_stubbed(:organization, status: :submitted))

      expect(helper.dashboard_for(@user)).to eq("organization_submitted_dashboard")
    end

    it "returns the organization approved dashboard for a user in an approved organization" do
      @user = double(:user, admin?: false)
      allow(@user).to receive_message_chain("organization.submitted?": false)
      allow(@user).to receive_message_chain("organization.approved?": true)
      # @user = build_stubbed(:user, organization: build_stubbed(:organization, status: :approved))

      expect(helper.dashboard_for(@user)).to eq("organization_approved_dashboard")
    end

    it "returns the create application dashboard for a user with no organization" do
      @user = double(:user, admin?: false)
      allow(@user).to receive_message_chain("organization.submitted?": false)
      allow(@user).to receive_message_chain("organization.approved?": false)
      # @user = build_stubbed(:user)

      expect(helper.dashboard_for(@user)).to eq("create_application_dashboard")
    end

  end

end
