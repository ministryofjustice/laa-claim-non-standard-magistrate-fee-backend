require 'rails_helper'

RSpec.describe Steps::ReasonForClaimForm do
  subject(:form) { described_class.new(arguments) }

  let(:arguments) do
    {
      application:,
      core_costs_exceed_higher_limit:,
      enhanced_rates_claimed:,
      counsel_or_agent_assigned:,
      representation_order_withdrawn:,
      extradition:,
      other:,
    }
  end

  let(:application) do
    instance_double(Claim)
  end

  let(:reason_for_claim) { nil }
  let(:core_costs_exceed_higher_limit) { nil }
  let(:enhanced_rates_claimed) { nil }
  let(:counsel_or_agent_assigned) { nil }
  let(:representation_order_withdrawn) { nil }
  let(:extradition) { nil }
  let(:other) { nil }

  describe '#save' do
    context 'when no choices are selected' do
      it 'has a validation error' do
        expect(form).not_to be_valid
        #expect(form.errors.of_kind?(:base, :invalid)).to be(true)
      end
    end

    context 'when `reason_for_claim` is valid' do
      let(:reason_for_claim) { ReasonForClaim::OTHER.to_s }
      it { is_expected.to be_valid }

      it 'passes validation' do
        expect(form.errors.of_kind?(:reason_for_claim, :invalid)).to be(false)
      end

      context 'when representation order withdrawn on' do
        let(:reason_for_claim) { ReasonForClaim::REPRESENTATION_ORDER_WITHDRAWN.to_s }

        context 'with a rep order date withdrawn on' do
          let(:representation_order_withdrawn_date) { Date.new(2023, 4, 1) }

          #it { is_expected.to be_valid }

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

      context 'return choices for reason for claim' do
        it 'returns all reason for claims choices' do
          expect(form.choices.count).to eq(6)
        end
      end

      context 'when reason of claim is other' do
        let(:reason_for_claim) { ReasonForClaim::OTHER.to_s }

        it 'is valid' do
          expect(form).to be_valid
        end
      end
    end
  end
end
