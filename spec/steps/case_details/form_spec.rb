require 'rails_helper'

RSpec.describe Steps::CaseDetailsForm do
  let(:form) { described_class.new(application:, **arguments) }

  let(:arguments) do
    {
      application:,
      ufn:,
      main_offence:,
      main_offence_date:,
      assigned_counsel:,
      unassigned_counsel:,
      agent_instructed:,
      remitted_to_magistrate:,
    }
  end

  let(:application) { instance_double(Claim, update!: true) }

  let(:ufn) { '1234' }
  let(:main_offence) { 'murder' }
  let(:main_offence_date) { Date.new(2023, 4, 1) }
  let(:unassigned_counsel) { 'no' }
  let(:assigned_counsel) { 'yes' }
  let(:agent_instructed) { 'yes' }
  let(:remitted_to_magistrate) { 'no' }

  describe '#save' do
    context 'when all fields are set' do
      it 'is valid' do
        expect(form.save).to be_truthy
        expect(application).to have_received(:update!)
        expect(form).to be_valid
      end
    end
  end

  describe '#valid?' do
    context 'when all fields are set' do
      it 'is valid' do
        expect(form).to be_valid
      end
    end
  end

  describe '#invalid?' do
    %i[ufn main_offence main_offence_date assigned_counsel unassigned_counsel agent_instructed
       remitted_to_magistrate].each do |field|
      context "when #{field} is missing" do
        let(field) { nil }

        it 'is valid' do
          expect(form).not_to be_valid
          expect(form.errors.of_kind?(field, :blank)).to be(true)
        end
      end
    end
  end
end
