require 'rails_helper'

RSpec.describe Steps::CostSummaryController, type: :controller do
  it_behaves_like 'a show step controller'

  describe '#show' do
    let(:claim) { Claim.create!(office_code: 'AAA') }

    before { claim.update(navigation_stack:) }

    context 'when page is already in navigation stack and at the end' do
      let(:navigation_stack) { ['/foo', "/applications/#{claim.id}/steps/cost_summary"] }

      it 'does not chnage the navigation stack' do
        get :show, params: { id: claim }
        expect(claim.reload).to have_attributes(
          navigation_stack:
        )
      end
    end

    context 'when page is already in navigation stack but not at the end' do
      let(:navigation_stack) { ["/applications/#{claim.id}/steps/cost_summary", '/foo'] }

      it 'removes entries after the page' do
        get :show, params: { id: claim }
        expect(claim.reload).to have_attributes(
          navigation_stack: ["/applications/#{claim.id}/steps/cost_summary"]
        )
      end
    end

    context 'when page is not in the navigation stack' do
      let(:navigation_stack) { ['/foo'] }

      it 'adds the page to the navigation stack' do
        get :show, params: { id: claim }
        expect(claim.reload).to have_attributes(
          navigation_stack: ['/foo', "/applications/#{claim.id}/steps/cost_summary"]
        )
      end
    end
  end
end
