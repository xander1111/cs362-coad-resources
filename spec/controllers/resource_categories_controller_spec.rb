require 'rails_helper'

RSpec.describe ResourceCategoriesController, type: :controller do

  context "no user" do

    describe "resource_category#index" do
      it "redirects to sign in page" do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end

  end

  context "normal user" do

    let (:user) { create(:user) }
    before(:each) { sign_in(user) }

    describe "resource_category#index" do
      it "redirects to dashboard" do
        get :index
        expect(response).to redirect_to(dashboard_path)
      end
    end

  end


  context "admin user" do

    let (:user) { create(:user, role: :admin) }
    before(:each) { sign_in(user) }

    describe "resource_category#index" do
      it "should be successful" do
        get :index
        expect(response).to be_successful
      end
    end

  end

end
