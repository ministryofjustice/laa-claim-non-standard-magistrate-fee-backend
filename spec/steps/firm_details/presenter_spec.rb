require 'rails_helper'

RSpec.describe Tasks::FirmDetails, type: :system do
  subject { described_class.new(application:) }

  let(:application) { Claim.new(attributes) }
  let(:attributes) do
    {
      id: id,
      office_code: 'AAA',
      firm_office: firm_office,
      solicitor: solicitor,
    }
  end
  let(:id) { SecureRandom.uuid }
  let(:firm_office) { nil }
  let(:solicitor) { nil }

  describe '#path' do
    it { expect(subject.path).to eq("/applications/#{id}/steps/firm_details") }
  end

  describe '#not_applicable?' do
    it { expect(subject).not_to be_not_applicable }
  end

  it_behaves_like 'a task with generic can_start?', Tasks::ClaimType
  it_behaves_like 'a task with generic complete?', Steps::FirmDetailsForm
end
