require 'rails_helper'

RSpec.describe ResourceCategoriesController, type: :controller do

  let (:res_cat) { create(:resource_category) }

  context "no user" do

    describe "resource_categories#index" do
      it "redirects to sign in page" do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "resource_categories#show" do
      it "redirects to sign in page" do
        get :show, params: { id: res_cat.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "resource_categories#new" do
      it "redirects to sign in page" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "resource_categories#create" do
      it "redirects to sign in page" do
        post :create, params: { resource_category: attributes_for(:resource_category) }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "resource_categories#edit" do
      it "redirects to sign in page" do
        get :edit, params: { id: res_cat.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "resource_categories#update" do
      it "redirects to sign in page" do
        patch :update, params: { id: res_cat.id, resource_category: attributes_for(:resource_category) }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "resource_categories#activate" do
      it "redirects to sign in page" do
        patch :activate, params: { id: res_cat.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "resource_categories#deactivate" do
      it "redirects to sign in page" do
        patch :deactivate, params: { id: res_cat.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "resource_categories#destroy" do
      it "redirects to sign in page" do
        allow(DeleteResourceCategoryService).to receive(:new).and_return(double(run!: nil)) 
        
        delete :destroy, params: { id: res_cat.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

  end

  context "normal user" do

    let (:user) { create(:user) }
    before(:each) { sign_in(user) }

    describe "resource_categories#index" do
      it "redirects to dashboard" do
        get :index
        expect(response).to redirect_to(dashboard_path)
      end
    end

    describe "resource_categories#show" do
      it "redirects to dashboard" do
        get :show, params: { id: res_cat.id }
        expect(response).to redirect_to(dashboard_path)
      end
    end

    describe "resource_categories#new" do
      it "redirects to dashboard" do
        get :new
        expect(response).to redirect_to(dashboard_path)
      end
    end

    describe "resource_categories#create" do
      it "redirects to dashboard" do
        post :create, params: { resource_category: attributes_for(:resource_category) }
        expect(response).to redirect_to(dashboard_path)
      end
    end

    describe "resource_categories#edit" do
      it "redirects to dashboard" do
        get :edit, params: { id: res_cat.id }
        expect(response).to redirect_to(dashboard_path)
      end
    end

    describe "resource_categories#update" do
      it "redirects to dashboard" do
        patch :update, params: { id: res_cat.id, resource_category: attributes_for(:resource_category) }
        expect(response).to redirect_to(dashboard_path)
      end
    end

    describe "resource_categories#activate" do
      it "redirects to dashboard" do
        patch :activate, params: { id: res_cat.id }
        expect(response).to redirect_to(dashboard_path)
      end
    end

    describe "resource_categories#deactivate" do
      it "redirects to dashboard" do
        patch :deactivate, params: { id: res_cat.id }
        expect(response).to redirect_to(dashboard_path)
      end
    end

    describe "resource_categories#destroy" do
      it "redirects to dashboard" do
        allow(DeleteResourceCategoryService).to receive(:new).and_return(double(run!: nil)) 
        
        delete :destroy, params: { id: res_cat.id }
        expect(response).to redirect_to(dashboard_path)
      end
    end

  end


  context "admin user" do

    let (:user) { create(:user, role: :admin) }
    before(:each) { sign_in(user) }

    describe "resource_categories#index" do
      it "should be successful" do
        get :index
        expect(response).to be_successful
      end
    end

    describe "resource_categories#show" do
      it "should be successful" do
        get :show, params: { id: res_cat.id }
        expect(response).to be_successful
      end
    end

    describe "resource_categories#new" do
      it "should be successful" do
        get :new
        expect(response).to be_successful
      end
    end

    describe "resource_categories#create" do

      it "redirects to the resource categories index page on success" do
        post :create, params: { resource_category: attributes_for(:resource_category) }
        expect(response).to redirect_to(resource_categories_path)
      end

      it "stays on the new page on failure" do
        allow_any_instance_of(ResourceCategory).to receive(:save).and_return(false)

        post :create, params: { resource_category: attributes_for(:resource_category) }
        expect(response).to be_successful
      end

    end

    describe "resource_categories#edit" do
      it "should be successful" do
        get :edit, params: { id: res_cat.id }
        expect(response).to be_successful
      end
    end

    describe "resource_categories#update" do

      it "redirects to the updated resource categories page on success" do
        patch :update, params: { id: res_cat.id, resource_category: attributes_for(:resource_category) }
        expect(response).to redirect_to(resource_category_path(res_cat.id))
      end

      it "stays on the edit page on failure" do
        allow_any_instance_of(ResourceCategory).to receive(:save).and_return(false)

        patch :update, params: { id: res_cat.id, resource_category: attributes_for(:resource_category) }
        expect(response).to be_successful
      end

    end

    describe "resource_categories#activate" do

      it "redirects to the activated resource categories page on success" do
        patch :activate, params: { id: res_cat.id }
        expect(response).to redirect_to(resource_category_path(res_cat.id))
      end

      it "redirects to the failed to activate resource categories page on failure" do
        allow_any_instance_of(ResourceCategory).to receive(:save).and_return(false)

        patch :activate, params: { id: res_cat.id }
        expect(response).to redirect_to(resource_category_path(res_cat.id))
      end

    end

    describe "resource_categories#deactivate" do

      it "redirects to the deactivated resource categories page on success" do
        patch :deactivate, params: { id: res_cat.id }
        expect(response).to redirect_to(resource_category_path(res_cat.id))
      end
      
      it "redirects to the failed to deactivate resource categories page on failure" do
        allow_any_instance_of(ResourceCategory).to receive(:save).and_return(false)
        
        patch :deactivate, params: { id: res_cat.id }
        expect(response).to redirect_to(resource_category_path(res_cat.id))
      end

    end

    describe "resource_categories#destroy" do
      it "redirects to the resource categories page" do
        allow(DeleteResourceCategoryService).to receive(:new).and_return(double(run!: nil)) 

        delete :destroy, params: { id: res_cat.id }
        expect(response).to redirect_to(resource_categories_path)
      end
    end

  end

end
