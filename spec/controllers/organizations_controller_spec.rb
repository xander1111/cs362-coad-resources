require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do

  context "no user" do
    describe "organizations#index" do

      it "redirects to sign in page" do
        get :index
        expect(response).to redirect_to('/users/sign_in')
      end

    end

    describe "organizations#create" do

      it "redirects to sign in page" do
        post(:create, params: { organization: attributes_for(:organization) })
        expect(response).to redirect_to('/users/sign_in')
      end

    end

    describe "organizations#new" do
      it "redirects to sign in page" do
        get :new
        expect(response).to redirect_to('/users/sign_in')
      end
    end

    describe "organizations#show" do
      it "redirects to sign in page" do
        get :show, params: { id: 1 }
        expect(response).to redirect_to('/users/sign_in')
      end
    end

    describe "organizations#edit" do
      it "redirects to sign in page" do
        get :edit, params: { id: 1 }
        expect(response).to redirect_to('/users/sign_in')
      end
    end

    describe "organizations#update" do
      it "redirects to sign in page" do
        @organization = create(:organization, name: "original name")
        patch :update, params: { id: @organization.id, organization: attributes_for(:organization).merge(name: "new name") }
        expect(response).to redirect_to('/users/sign_in')
      end
    end

  end

  context "unapproved user" do

    let (:user) { create(:user) }
    before(:each) {
      create(:user, role: :admin)
      sign_in(user)
    }

    describe "organizations#index" do
      it "should be successful" do
        get :index
        expect(response).to be_successful
      end

    end

    describe "organizations#create" do

      it "redirects to the submitted path" do
        post(:create, params: { organization: attributes_for(:organization) })
        expect(response).to redirect_to(organization_application_submitted_path)
      end

    end

    describe "organizations#new" do

      it "should be successful" do
        get :new
        expect(response).to be_successful
      end

    end

    describe "organizations#show" do
      it "redirects to dashboard" do
        get :show, params: { id: 1 }
        expect(response).to redirect_to(dashboard_path)
      end
    end

    describe "organizations#edit" do
      it "redirects to dashbaord" do
        get :edit, params: { id: 1 }
        expect(response).to redirect_to(dashboard_path)
      end
    end

    describe "organizations#update" do
      it "redirects to dashboard" do
        @organization = create(:organization, name: "original name")
        patch :update, params: { id: @organization.id, organization: attributes_for(:organization).merge(name: "new name") }
        expect(response).to redirect_to(dashboard_path)
      end
    end

  end


  context "approved user" do

    let (:approved_org) { create(:organization, status: :approved) }
    let (:user) { create(:user, organization: approved_org) }
    before(:each) {
      create(:user, role: :admin)
      sign_in(user)
    }

    describe "organizations#index" do
      it "should be successful" do
        get :index
        expect(response).to be_successful
      end

    end

    describe "organizations#create" do
      it "redirects to the dashboard" do
        post(:create, params: { organization: attributes_for(:organization) })
        expect(response).to redirect_to(dashboard_path)
      end
    end

    describe "organizations#new" do
      it "redirects to dashboard" do
        get :new
        expect(response).to redirect_to(dashboard_path)
      end
    end

    describe "organizations#show" do
      it "should be successful" do
        get :show, params: { id: 1 }
        expect(response).to be_successful
      end
    end

    describe "organizations#edit" do
      it "should be successful" do
        allow(user).to receive(:organization).and_return(double(:organization, approved?: true))
        get :edit, params: { id: 1 }
        expect(response).to be_successful
      end
    end

    describe "organizations#update" do
      it "" do
        @organization = create(:organization, name: "original name")
        patch :update, params: { id: @organization.id, organization: attributes_for(:organization).merge(name: "new name") }
        expect(response).to redirect_to(organization_path(id: @organization.id))
      end
    end

  end

  context "admin user" do

    let (:user) { create(:user, role: :admin) }
    before(:each) { sign_in(user) }

    describe "organizations#index" do
      it "should be successful" do
        get :index
        expect(response).to be_successful
      end

    end

    describe "organizations#create" do

      it "redirects to the dashboard" do
        post(:create, params: { organization: attributes_for(:organization) })
        expect(response).to redirect_to(dashboard_path)
      end

    end

    describe "organizations#new" do

      it "redirects to the dashboard" do
        get :new
        expect(response).to redirect_to(dashboard_path)
      end

    end

    describe "organizations#show" do
      it "should be successful" do
        create(:organization, status: :submitted)
        get :show, params: { id: 1 }
        expect(response).to be_successful
      end
    end

    describe "organizations#edit" do
      it "redirects to dashboard" do
        get :edit, params: { id: 1 }
        expect(response).to redirect_to(dashboard_path)
      end
    end

    describe "organizations#update" do
      it "redirects to dashboard" do
        @organization = create(:organization, name: "original name")
        patch :update, params: { id: @organization.id, organization: attributes_for(:organization).merge(name: "new name") }
        expect(response).to redirect_to(dashboard_path)
      end
    end

  end

end
