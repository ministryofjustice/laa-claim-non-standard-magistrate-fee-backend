require 'rails_helper'

RSpec.describe Steps::ClaimDetailsForm do
  subject { described_class.new(application:, **arguments) }

  let(:arguments) do
    {
      application:,
      prosecution_evidence:,
      defence_statement:,
      number_of_witnesses:,
      supplemental_claim:,
      preparation_time:,
      time_spent:,
      work_before:,
      work_after:,
      work_before_date:,
      work_after_date:,
    }
  end

  let(:application) { instance_double(Claim, update!: true) }

  let(:prosecution_evidence) { 1 }
  let(:defence_statement) { 2 }
  let(:number_of_witnesses) { 3 }
  let(:supplemental_claim) { 'yes' }
  let(:preparation_time) { 'yes' }
  let(:work_before) { 'yes' }
  let(:work_after) { 'yes' }
  let(:work_before_date) { Date.yesterday }
  let(:work_after_date) { Date.yesterday }
  let(:time_spent) { { 1 => hours, 2 => minutes } }
  let(:hours) { 2 }
  let(:minutes) { 40 }

  describe '#save preparation time yes' do
    context 'when all fields are set and preparation_time set to yes' do
      let(:preparation_time) { 'yes' }

      it 'is valid' do
        expect(subject.save).to be_truthy
        expect(application).to have_received(:update!)
        expect(subject).to be_valid
      end
    end
  end

  describe '#save' do
    let(:application) { Claim.create(office_code: 'AAA', time_spent: time_spent_in_db) }
    let(:time_spent_in_db) { nil }

    context 'when preparation is yes' do
      let(:preparation_time) { 'yes' }

      context 'when time_spent is valid' do
        it 'is updated the DB in minutes' do
          expect(subject.save).to be_truthy
          expect(application.reload).to have_attributes(
            time_spent: 160
          )
        end
      end
    end

    context 'when preparation is no' do
      let(:preparation_time) { 'no' }

      context 'time_spent has a value in the database' do
        let(:time_spent_in_db) { 100 }

        it 'clears the database field' do
          expect(subject.save).to be_truthy
          expect(application.reload).to have_attributes(
            time_spent: nil
          )
        end
      end
    end
  end

  describe '#validations' do
    context 'work_before_date' do
      context 'and work_before is nil' do
        let(:work_before) { nil }

        it 'is valid' do
          expect(subject).to be_valid
        end
      end

      context 'when work before is valid' do
        let(:work_before) { nil }

        it 'is is valid' do
          expect(subject.save).to be_truthy
        end
      end

      context 'and work_before is no' do
        let(:work_before) { 'no' }

        it { expect(subject).to be_valid }
      end

      context 'and work_before is yes' do
        let(:work_before) { 'yes' }
        let(:work_before_date) { nil }

        it 'is not valid' do
          expect(subject).not_to be_valid
          expect(subject.errors.of_kind?(:work_before_date, :blank)).to be(true)
        end
      end
    end

    context 'work_after_date' do
      context 'and work_after is nil' do
        let(:work_after) { nil }

        it { expect(subject).to be_valid }
      end

      context 'and work_after is no' do
        let(:work_after) { 'no' }

        it { expect(subject).to be_valid }
      end

      context 'and work_after is yes' do
        let(:work_after) { 'yes' }
        let(:work_after_date) { nil }

        it 'is not valid' do
          expect(subject).not_to be_valid
          expect(subject.errors.of_kind?(:work_after_date, :blank)).to be(true)
        end
      end
    end
  end
end
