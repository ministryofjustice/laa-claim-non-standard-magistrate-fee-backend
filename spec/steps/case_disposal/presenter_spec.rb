require 'rails_helper'

RSpec.describe Tasks::CaseDisposal, type: :system do
  subject { described_class.new(application:) }

  let(:application) { Claim.new(attributes) }
  let(:attributes) do
    {
      id: id,
      office_code: 'AAA',
      plea: plea
    }
  end
  let(:id) { SecureRandom.uuid }
  let(:plea) { nil }

  describe '#path' do
    it { expect(subject.path).to eq("/applications/#{id}/steps/case_disposal") }
  end

  describe '#not_applicable?' do
    it { expect(subject).not_to be_not_applicable }
  end

  it_behaves_like 'a task with generic can_start?', Tasks::HearingDetails
  it_behaves_like 'a task with generic complete?', Steps::CaseDisposalForm

  describe '#in_progress?' do
    it { expect(subject).not_to be_in_progress }
  end
end
