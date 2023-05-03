require 'rails_helper'

RSpec.describe ClaimsController do
  context 'index' do
    before do
      allow(Claim).to receive(:all).and_return([instance_double(Claim)])
    end

    it 'render all claims' do
      get :index
      expect(response).to be_successful
      expect(Claim).to have_received(:all)
    end
  end

  context 'create' do
    let(:claim) { instance_double(Claim, id: SecureRandom.uuid) }

    before do
      allow(Claim).to receive(:create!).and_return(claim)
    end

    it 'create a new Claim application with the users office_code' do
      post :create
      expect(Claim).to have_received(:create!).with(office_code: 'AAA')
    end

    it 'redirects to the edit claim type step' do
      post :create
      expect(response).to redirect_to(edit_steps_claim_type_path(claim.id))
    end
  end
end