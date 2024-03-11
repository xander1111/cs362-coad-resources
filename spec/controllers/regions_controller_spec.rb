require 'rails_helper'

RSpec.describe RegionsController, type: :controller do

  let (:region) { create(:region) }

  context "no user" do

    describe "regions#index" do
      it "redirects to sign in page" do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end

  end

  context "normal user" do

    let (:user) { create(:user) }
    before(:each) { sign_in(user) }


    describe "regions#index" do
      it "redirects to dashboard path" do
        get :index
        expect(response).to redirect_to(dashboard_path)
      end
    end

  end

  context "admin user" do

    let (:user) { create(:user, role: :admin) }
    before(:each) { sign_in(user) }

    describe "regions#index" do
      it "should be successful" do
        get :index
        expect(response).to be_successful
      end
    end

  end

  # context 'as an admin user' do
  #   let(:user) { create(:user, :admin) }
  #   before(:each) { sign_in(user) }

  #   let(:region) { create(:region) }

  #   describe "POST #create" do
  #     it {
  #       post(:create, params: { region: attributes_for(:region) })
  #       expect(response).to redirect_to(regions_path)
  #     }

  #     it {
  #       expect_any_instance_of(Region).to receive(:save).and_return(false)
  #       post(:create, params: { region: attributes_for(:region) })
  #       expect(response).to be_successful
  #     }


  #   end

  # end

end