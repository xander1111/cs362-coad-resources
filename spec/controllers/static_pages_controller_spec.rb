require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do

  context "no user" do

    describe "static_pages#index" do
      it "should be successful" do
        get :index
        expect(response).to be_successful
      end
    end

  end

  context "normal user" do

    let (:user) { create(:user) }
    before(:each) { sign_in(user) }

    describe "static_pages#index" do
      it "should be successful" do
        get :index
        expect(response).to be_successful
      end
    end

  end


  context "admin user" do

    let (:user) { create(:user, role: :admin) }
    before(:each) { sign_in(user) }

    describe "static_pages#index" do
      it "should be successful" do
        get :index
        expect(response).to be_successful
      end
    end

  end

end
