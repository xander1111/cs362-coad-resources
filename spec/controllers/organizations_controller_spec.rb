require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do

  context "no user" do
    describe "GET /organizations" do

      it "redirects to sign in page" do
        get :index
        expect(response).to redirect_to('/users/sign_in')
      end

    end

    describe "POST /organizations" do

      it "redirects to sign in page" do
        post(:create, params: { organization: attributes_for(:organization) })
        expect(response).to redirect_to('/users/sign_in')
      end

    end

    describe "GET /organizations/new" do
      it "redirects to sign in page" do
        get :new
        expect(response).to redirect_to('/users/sign_in')
      end
    end

  end

  context "normal user" do

    let (:user) { create(:user) }
    before(:each) {
      create(:user, role: :admin)
      sign_in(user)
    }

    describe "GET /organizations" do
      it "should be successful" do
        get :index
        expect(response).to be_successful
      end

    end

    describe "POST /organizations" do

      it "redirects to the submitted path" do
        post(:create, params: { organization: attributes_for(:organization) })
        expect(response).to redirect_to(organization_application_submitted_path)
      end

    end

    describe "GET /organizations/new" do

      it "should be successful" do
        get :new
        expect(response).to be_successful
      end

    end

  end

  context "admin user" do

    let (:user) { create(:user, role: :admin) }
    before(:each) { sign_in(user) }

    describe "GET /organizations" do
      it "should be successful" do
        get :index
        expect(response).to be_successful
      end

    end

    describe "POST /organizations" do

      it "redirects to the dashboard" do
        post(:create, params: { organization: attributes_for(:organization) })
        expect(response).to redirect_to(dashboard_path)
      end

    end

    describe "GET /organizations/new" do

      it "redirects to the dashboard" do
        get :new
        expect(response).to redirect_to(dashboard_path)
      end

    end

  end

end
