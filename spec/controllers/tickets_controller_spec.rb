require 'rails_helper'

RSpec.describe TicketsController, type: :controller do

  let (:region) { build_stubbed(:region) }
  let (:res_cat) { build_stubbed(:resource_category) }
  let (:ticket) { create(:ticket, region: region, resource_category: res_cat) }

  context "no user" do

    describe "tickets#show" do
      it "redirects to dashboard" do
        get :show, params: { id: ticket.id }
        expect(response).to redirect_to(dashboard_path)
      end
    end

    describe "tickets#new" do
      it "should be successful" do
        get :new
        expect(response).to be_successful
      end
    end

    describe "tickets#create" do

      it "redirects to the ticket submitted page on success" do
        allow(Ticket).to receive(:new).and_return(double(:ticket, save: true))
        post :create, params: { ticket: attributes_for(:ticket) }
        expect(response).to redirect_to(ticket_submitted_path)
      end

      it "stays on the new page on failure" do
        allow(Ticket).to receive(:new).and_return(double(:ticket, save: false))
        post :create, params: { ticket: attributes_for(:ticket) }
        expect(response).to be_successful
      end

    end

    describe "tickets#capture" do
      it "redirects to dashboard" do
        post :capture, params: { id: ticket.id }
        expect(response).to redirect_to(dashboard_path)
      end
    end

    describe "tickets#release" do
      it "redirects to dashboard" do
        post :release, params: { id: ticket.id }
        expect(response).to redirect_to(dashboard_path)
      end
    end

    describe "tickets#close" do
      it "redirects to dashboard" do
        post :close, params: { id: ticket.id }
        expect(response).to redirect_to(dashboard_path)
      end
    end

    describe "tickets#destroy" do
      it "redirects to dashboard" do
        delete :destroy, params: { id: ticket.id }
        expect(response).to redirect_to(dashboard_path)
      end
    end

  end

  context "unapproved user" do

    let (:user) { create(:user) }
    before(:each) { sign_in(user) }

    describe "tickets#show" do
      it "redirects to dashboard" do
        get :show, params: { id: ticket.id }
        expect(response).to redirect_to(dashboard_path)
      end
    end

    describe "tickets#new" do
      it "should be successful" do
        get :new
        expect(response).to be_successful
      end
    end

    describe "tickets#create" do

      it "should be successful" do
        allow(Ticket).to receive(:new).and_return(double(:ticket, save: true))
        post :create, params: { ticket: attributes_for(:ticket) }
        expect(response).to redirect_to(ticket_submitted_path)
      end

      it "stays on the new page on failure" do
        allow(Ticket).to receive(:new).and_return(double(:ticket, save: false))
        post :create, params: { ticket: attributes_for(:ticket) }
        expect(response).to be_successful
      end

    end

    describe "tickets#capture" do
      it "redirects to dashboard" do
        post :capture, params: { id: ticket.id }
        expect(response).to redirect_to(dashboard_path)
      end
    end

    describe "tickets#release" do
      it "redirects to dashboard" do
        post :release, params: { id: ticket.id }
        expect(response).to redirect_to(dashboard_path)
      end
    end

    describe "tickets#close" do
      it "redirects to dashboard" do
        post :close, params: { id: ticket.id }
        expect(response).to redirect_to(dashboard_path)
      end
    end

    describe "tickets#destroy" do
      it "redirects to dashboard" do
        delete :destroy, params: { id: ticket.id }
        expect(response).to redirect_to(dashboard_path)
      end
    end

  end

  context "approved user" do

    let (:approved_org) { create(:organization, status: :approved) }
    let (:user) { create(:user, organization: approved_org) }
    before(:each) { sign_in(user) }

    describe "tickets#show" do
      it "should be successful" do
        get :show, params: { id: ticket.id }
        expect(response).to be_successful
      end
    end

    describe "tickets#new" do
      it "should be successful" do
        get :new
        expect(response).to be_successful
      end
    end

    describe "tickets#create" do

      it "should be successful" do
        allow(Ticket).to receive(:new).and_return(double(:ticket, save: true))
        post :create, params: { ticket: attributes_for(:ticket) }
        expect(response).to redirect_to(ticket_submitted_path)
      end

      it "stays on the new page on failure" do
        allow(Ticket).to receive(:new).and_return(double(:ticket, save: false))
        post :create, params: { ticket: attributes_for(:ticket) }
        expect(response).to be_successful
      end
      
    end

    describe "tickets#capture" do

      it "redirects to the open tickets section of the dashboard page on success" do
        allow(TicketService).to receive(:capture_ticket).and_return(:ok)
        post :capture, params: { id: ticket.id }
        expect(response).to redirect_to(dashboard_path << '#tickets:open')
      end

       it "stays on the ticket's page on failure" do
        allow(TicketService).to receive(:capture_ticket).and_return(nil)
        post :capture, params: { id: ticket.id }
        expect(response).to be_successful
      end

    end

    describe "tickets#release" do

      it "redirects to the organization tickets section of the dashboard page" do
        allow(TicketService).to receive(:release_ticket).and_return(:ok)
        post :release, params: { id: ticket.id }
        expect(response).to redirect_to(dashboard_path << '#tickets:organization')
      end

      it "stays on the ticket's page on failure" do
        allow(TicketService).to receive(:release_ticket).and_return(nil)
        post :release, params: { id: ticket.id }
        expect(response).to be_successful
      end

    end

    describe "tickets#close" do

      it "redirects to the organization tickets section of the dashboard page" do
        allow(TicketService).to receive(:close_ticket).and_return(:ok)
        post :close, params: { id: ticket.id }
        expect(response).to redirect_to(dashboard_path << '#tickets:organization')
      end

      it "stays on the ticket's page on failure" do
        allow(TicketService).to receive(:close_ticket).and_return(nil)
        post :close, params: { id: ticket.id }
        expect(response).to be_successful
      end

    end

    describe "tickets#destroy" do
      it "redirects to dashboard" do
        delete :destroy, params: { id: ticket.id }
        expect(response).to redirect_to(dashboard_path)
      end
    end

  end

  context "admin user" do

    let (:user) { create(:user, role: :admin) }
    before(:each) { sign_in(user) }

    describe "tickets#show" do
      it "should be successful" do
        get :show, params: { id: ticket.id }
        expect(response).to be_successful
      end
    end

    describe "tickets#new" do
      it "should be successful" do
        get :new
        expect(response).to be_successful
      end
    end

    describe "tickets#create" do

      it "should be successful" do
        allow(Ticket).to receive(:new).and_return(double(:ticket, save: true))
        post :create, params: { ticket: attributes_for(:ticket) }
        expect(response).to redirect_to(ticket_submitted_path)
      end

      it "stays on the new page on failure" do
        allow(Ticket).to receive(:new).and_return(double(:ticket, save: false))
        post :create, params: { ticket: attributes_for(:ticket) }
        expect(response).to be_successful
      end

    end

    describe "tickets#capture" do
      it "redirects to dashboard" do
        post :capture, params: { id: ticket.id }
        expect(response).to redirect_to(dashboard_path)
      end
    end

    describe "tickets#release" do

      it "redirects to the captured tickets section of the dashboard page on success" do
        allow(TicketService).to receive(:release_ticket).and_return(:ok)
        post :release, params: { id: ticket.id }
        expect(response).to redirect_to(dashboard_path << '#tickets:captured')
      end

      it "stays on the ticket's page on failure" do
        allow(TicketService).to receive(:release_ticket).and_return(nil)
        post :release, params: { id: ticket.id }
        expect(response).to be_successful
      end

    end

    describe "tickets#close" do

      it "redirects to the open tickets section of the dashboard page on success" do
        allow(TicketService).to receive(:close_ticket).and_return(:ok)
        post :close, params: { id: ticket.id }
        expect(response).to redirect_to(dashboard_path << '#tickets:open')
      end

      it "stays on the ticket's page on failure" do
        allow(TicketService).to receive(:close_ticket).and_return(nil)
        post :close, params: { id: ticket.id }
        expect(response).to be_successful
      end

    end

    describe "tickets#destroy" do
      it "redirects to the tickets section of the dashboard page" do
        delete :destroy, params: { id: ticket.id }
        expect(response).to redirect_to(dashboard_path << '#tickets')
      end
    end

  end
end
