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

    describe "regions#show" do
      it "redirects to sign in page" do
        get :show, params: { id: region.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "regions#new" do
      it "redirects to sign in page" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "regions#create" do
      it "redirects to sign in page" do
        post :create, params: { region: attributes_for(:region) }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe "regions#edit" do
      it "redirects to sign in page" do
        get :edit, params: { id: region.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "regions#update" do
      it "redirects to sign in page" do
        patch :update, params: { id: region.id, region: attributes_for(:region) }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "regions#destroy" do
      it "redirects to sign in page" do
        delete :destroy, params: { id: region.id }
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

    describe "regions#show" do
      it "redirects to dashboard" do
        get :show, params: { id: region.id }
        expect(response).to redirect_to(dashboard_path)
      end
    end

    describe "regions#new" do
      it "redirects to dashboard path" do
        get :new
        expect(response).to redirect_to(dashboard_path)
      end
    end

    describe "regions#create" do
      it "redirects to dashboard" do
        post :create, params: { region: attributes_for(:region) }
        expect(response).to redirect_to(dashboard_path)
      end
    end

    describe "regions#edit" do
      it "redirects to dashboard" do
        get :edit, params: { id: region.id }
        expect(response).to redirect_to(dashboard_path)
      end
    end

    describe "regions#update" do
      it "redirects to dashboard" do
        patch :update, params: { id: region.id, region: attributes_for(:region) }
        expect(response).to redirect_to(dashboard_path)
      end
    end

    describe "regions#destroy" do
      it "redirects to dashboard" do
        delete :destroy, params: { id: region.id }
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

    describe "regions#show" do
      it "should be successful" do
        get :show, params: { id: region.id }
        expect(response).to be_successful
      end
    end

    describe "regions#new" do
      it "should be successful" do
        get :new
        expect(response).to be_successful
      end
    end

    describe "regions#create" do
      it "redirects to the regions page on success" do
        post :create, params: { region: attributes_for(:region) }
        expect(response).to redirect_to(regions_path)
      end

       it "stays on the new page on failure" do
        expect_any_instance_of(Region).to receive(:save).and_return(false)
        
        post :create, params: { region: attributes_for(:region) }
        expect(response).to be_successful
      end
    end

    describe "regions#edit" do
      it "should be successful" do
        get :edit, params: { id: region.id }
        expect(response).to be_successful
      end
    end

    describe "regions#update" do
      it "redirects to the updated region's page on success" do
        patch :update, params: { id: region.id, region: attributes_for(:region) }
        expect(response).to redirect_to(region_path(region.id))
      end

      it "stays on the edit region page on failure" do
        expect_any_instance_of(Region).to receive(:save).and_return(false)
        
        patch :update, params: { id: region.id, region: attributes_for(:region) }
        expect(response).to be_successful
      end
    end

    describe "regions#destroy" do
      it "redirects to the regions page" do
        delete :destroy, params: { id: region.id }
        expect(response).to redirect_to(regions_path)
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