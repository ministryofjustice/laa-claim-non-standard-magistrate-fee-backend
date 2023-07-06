require 'rails_helper'

RSpec.describe Steps::DefendantDetailsController, type: :controller do
  let(:defendant) { existing_case.is_a?(Claim) ? existing_case.defendants.create : nil }

  it_behaves_like 'a generic step controller', Steps::DefendantDetailsForm, Decisions::SimpleDecisionTree,
                  ->(scope) { { defendant_id: scope.defendant&.id || '4321' } }
  it_behaves_like 'a step that can be drafted', Steps::DefendantDetailsForm,
                  ->(scope) { { defendant_id: scope.defendant&.id || '4321' } }

  describe '#edit' do
    let(:application) { Claim.create(office_code: 'AA1', defendants: defendants) }
    let(:defendants) { [] }

    context 'when defendant_id CREATE_FIRST flag passed as id' do
      it 'does not save the new defendant it passes to the form' do
        allow(Steps::DefendantDetailsForm).to receive(:build)
        expect { get :edit, params: { id: application, defendant_id: StartPage::CREATE_FIRST } }
          .to change(application.defendants, :count).by(0)

        expect(Steps::DefendantDetailsForm).to have_received(:build) do |defend, **kwargs|
          expect(defend).to be_a(Defendant)
          expect(defend).to be_new_record
          expect(kwargs).to eq(application: application)
        end
      end

      context 'and more than one defendent exists' do
        let(:defendants) { [Defendant.new, Defendant.new] }

        it 'redirects to the summary page' do
          expect do
            get :edit, params: { id: application, defendant_id: StartPage::CREATE_FIRST }
          end.not_to change(application.disbursements, :count)

          expect(response).to redirect_to(edit_steps_defendant_summary_path(application))
        end
      end
    end

    context 'when defendant_id is passed in' do
      context 'and defendant exists' do
        let(:defendants) { [Defendant.new(full_name: 'Jim', maat: 'AA1', main: true, position: 1)] }

        it 'passes the existing defendant to the form' do
          allow(Steps::DefendantDetailsForm).to receive(:build)
          expect do
            get :edit,
                params: { id: application, defendant_id: application.defendants.first.id }
          end.not_to change(application.defendants, :count)

          expect(Steps::DefendantDetailsForm).to have_received(:build).with(defendants.first, application:)
        end
      end

      context 'and defendant does not exists' do
        let(:defendants) { [Defendant.new(full_name: 'Jim', maat: 'AA1', main: true, position: 1)] }

        it 'redirect to the summary screen' do
          expect do
            get :edit, params: { id: application, defendant_id: SecureRandom.uuid }
          end.not_to change(application.defendants, :count)

          expect(response).to redirect_to(edit_steps_defendant_summary_path(application))
        end
      end
    end
  end
end
