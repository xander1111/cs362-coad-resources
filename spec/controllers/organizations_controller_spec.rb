require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do

  describe "GET /organizations" do

    context "logged out user" do
    
      it "redirects to sign in page" do
        get :index
        expect(response).to redirect_to('/users/sign_in')
      end

    end

    context "normal user" do
        
      it "should be successful" do
        user = create(:user)
        sign_in(user) 
        get :index
        expect(response).to be_successful
      end

    end
  
    context "admin user" do
  
      it "should be successful" do
        user = create(:user, role: :admin)
        sign_in(user) 
        get :index
        expect(response).to be_successful
      end

    end

  end

end
