require 'rails_helper'

RSpec.describe RegionsController, type: :controller do

  context 'as an admin user' do
    let(:user) { create(:user, :admin) }
    before(:each) { sign_in(user) }

    let(:region) { create(:region) }

    describe "POST #create" do
      it {
        post(:create, params: { region: attributes_for(:region) })
        expect(response).to redirect_to(regions_path)
      }

      it {
        expect_any_instance_of(Region).to receive(:save).and_return(false)
        post(:create, params: { region: attributes_for(:region) })
        expect(response).to be_successful
      }


    end

  end

end