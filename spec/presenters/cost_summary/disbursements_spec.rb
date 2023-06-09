require 'rails_helper'

RSpec.describe CostSummary::Disbursements do
  subject { described_class.new(disbursements, claim) }

  let(:claim) { instance_double(Claim, assigned_counsel:, in_area:) }
  let(:assigned_counsel) { 'no' }
  let(:in_area) { 'yes' }
  let(:disbursements) do
    [
      instance_double(Disbursement, disbursement_type: 'car', other_type: nil),
      instance_double(Disbursement, disbursement_type: 'other', other_type: 'dna_testing'),
      instance_double(Disbursement, disbursement_type: 'other', other_type: 'Custom'),
      instance_double(Disbursement, disbursement_type: 'car', other_type: nil)
    ]
  end
  let(:form_car) { instance_double(Steps::DisbursementCostForm, record: disbursements[0], total_cost: 100.0) }
  let(:form_dna) { instance_double(Steps::DisbursementCostForm, record: disbursements[1], total_cost: 70.0) }
  let(:form_custom) { instance_double(Steps::DisbursementCostForm, record: disbursements[2], total_cost: 40.0) }
  let(:form_car2) { instance_double(Steps::DisbursementCostForm, record: disbursements[3], total_cost: 90.0) }

  before do
    allow(Steps::DisbursementCostForm).to receive(:build).with(disbursements[0],
                                                               application: claim).and_return(form_car)
    allow(Steps::DisbursementCostForm).to receive(:build).with(disbursements[1],
                                                               application: claim).and_return(form_dna)
    allow(Steps::DisbursementCostForm).to receive(:build).with(disbursements[2],
                                                               application: claim).and_return(form_custom)
    allow(Steps::DisbursementCostForm).to receive(:build).with(disbursements[3],
                                                               application: claim).and_return(form_car2)
  end

  describe '#initialize' do
    it 'creates the data instance' do
      subject
      expect(Steps::DisbursementCostForm).to have_received(:build).with(disbursements[0], application: claim)
      expect(Steps::DisbursementCostForm).to have_received(:build).with(disbursements[1], application: claim)
      expect(Steps::DisbursementCostForm).to have_received(:build).with(disbursements[2], application: claim)
      expect(Steps::DisbursementCostForm).to have_received(:build).with(disbursements[3], application: claim)
    end
  end

  # rubocop:disable RSpec/ExampleLength
  describe '#rows' do
    it 'generates letters and calls rows' do
      expect(subject.rows).to eq(
        [
          {
            key: { classes: 'govuk-summary-list__value-width-50', text: 'Car' },
            value: { text: '£100.00' }
          },
          {
            key: { classes: 'govuk-summary-list__value-width-50', text: 'DNA Testing' },
            value: { text: '£70.00' }
          },
          {
            key: { classes: 'govuk-summary-list__value-width-50', text: 'Custom' },
            value: { text: '£40.00' }
          },
          {
            key: { classes: 'govuk-summary-list__value-width-50', text: 'Car' },
            value: { text: '£90.00' }
          }
        ]
      )
    end
  end
  # rubocop:enable RSpec/ExampleLength

  describe '#total_cost' do
    it 'delegates to the form' do
      expect(subject.total_cost).to eq(300.00)
    end
  end

  describe '#title' do
    it 'translates with total cost' do
      expect(subject.title).to eq('Disbursements total £300.00')
    end
  end
end
