require 'rails_helper'

RSpec.describe Steps::CaseDetailsForm do
  subject(:form) { described_class.new(arguments) }

  let(:arguments) do
    {
      application:,
      assigned_counsel:,
      unassigned_counsel:,
      agent_instructed:,
      remitted_to_magistrate:,
    }
  end

  let(:application) do
    instance_double(Claim)
  end


    let(:assigned_counsel)  { nil }
    let(:unassigned_counsel){ nil }
    let(:agent_instructed)  { nil }
    let(:remitted_to_magistrate) { nil }

  describe '#save' do
    context 'when no choices are selected' do
    let(:assigned_counsel)  { nil }
    let(:unassigned_counsel){ nil }
    let(:agent_instructed)  { nil }
    let(:remitted_to_magistrate) { nil }
      it 'has a validation error' do
        expect(form).not_to be_valid
        expect(form.errors.of_kind?(:base, :invalid)).to be(true)
      end
    end

    describe '#save' do
      context 'when one choice is selected' do
    let(:assigned_counsel)  { nil }
    let(:unassigned_counsel){ nil }
    let(:agent_instructed)  { nil }
    let(:remitted_to_magistrate) { nil }
        it 'has no validation error' do
          expect(form).to be_valid

          #expect(firm_office_form).to have_received(:save!)
          # expect(form.errors.of_kind?(:base, :valid)).to be(true)
        end
      end

      context 'when `case_details` is valid' do
        let(:case_details) { CaseDetails::OTHER.to_s }
        it { is_expected.to be_valid }

        it 'passes validation' do
          expect(form.errors.of_kind?(:case_details, :invalid)).to be(false)
        end

        context 'when representation order withdrawn on' do
          let(:case_details) { CaseDetails::REPRESENTATION_ORDER_WITHDRAWN.to_s }

          context 'with a rep order date withdrawn on' do
            let(:representation_order_withdrawn_date) { Date.new(2023, 4, 1) }

            # it { is_expected.to be_valid }

            it 'can reset representation_order_withdrawn_date (leave rep order date withdrawn)' do
              attributes = form.send(:attributes_to_reset)
              expect(attributes).to eq(
                                      'representation_order_withdrawn_date' => representation_order_withdrawn_date,
                                    )
            end
          end

          context 'without a rep order date withdrawn' do
            it 'is invalid' do
              expect(form).not_to be_valid
              expect(form.errors.of_kind?(:representation_order_withdrawn_date, :blank)).to be(true)
            end
          end
        end

        context 'return choices for case_details for claim' do
          it 'returns all reason for claims choices' do
            expect(form.choices.count).to eq(6)
          end
        end

        context 'when reason of claim is other' do
          let(:case_details) { CaseDetails::OTHER.to_s }

          it 'is valid' do
            expect(form).to be_valid
          end
        end
      end
    end
  end
end
