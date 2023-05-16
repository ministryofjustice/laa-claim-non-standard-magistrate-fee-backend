require 'rails_helper'

RSpec.describe Decisions::SimpleDecisionTree do
  let(:application) { Claim.new(id: SecureRandom.uuid) }

  context 'when step is claim_type' do
    context 'and claim_type is supported' do
      it 'processes to the firm_details page' do
        ClaimType::SUPPORTED.each do |claim_type|
          claim = Steps::ClaimTypeForm.new(application:, claim_type:)
          decision_tree = described_class.new(claim, as: :claim_type)
          expect(decision_tree.destination).to eq(
                                                 action: :edit,
                                                 controller: :firm_details,
                                                 id: application,
                                               )
        end
      end
    end

    context 'and claim_type is not supported' do
      it 'processes to the firm_details page' do
        (ClaimType::VALUES - ClaimType::SUPPORTED).each do |claim_type|
          claim = Steps::ClaimTypeForm.new(application:, claim_type:)
          decision_tree = described_class.new(claim, as: :claim_type)
          expect(decision_tree.destination).to eq(
                                                 action: :edit,
                                                 controller: :firm_details,
                                                 id: application,
                                               )
        end
      end
    end
  end

  context 'when step is firm_details' do
    # TODO: update this when case_details implemented
    it 'moves to case details page' do
      claim = Steps::FirmDetailsForm.new(application:)
      decision_tree = described_class.new(claim, as: :firm_details)
      expect(decision_tree.destination).to eq(
        action: :edit,
        controller: :case_disposal,
        id: application,
      )
    end
  end

  context 'when step is case_disposal' do
    context 'when plea is guilty' do
      before { application.plea = true }

      # TODO: update this when guilty implemented
      it 'moves to guilty page' do
        claim = Steps::CaseDisposalForm.new(application:)
        decision_tree = described_class.new(claim, as: :case_disposal)
        expect(decision_tree.destination).to eq(
          action: :index,
          controller: '/claims',
        )
      end
    end

    context 'when plea is not guilty' do
      before { application.plea = false }

      # TODO: update this when guilty implemented
      it 'moves to hearing details page' do
        claim = Steps::CaseDisposalForm.new(application:)
        decision_tree = described_class.new(claim, as: :case_disposal)
        expect(decision_tree.destination).to eq(
          action: :index,
          controller: '/claims',
        )
      end
    end
  end

  context 'when step is unknown' do
    # TODO: update this when implemented
    it 'moves to claim index' do
      decision_tree = described_class.new(double('form'), as: :unknown)
      expect(decision_tree.destination).to eq(
                                             action: :index,
                                             controller: '/claims',
                                           )
    end
  end
end
