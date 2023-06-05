require 'rails_helper'

RSpec.describe Steps::OtherInfoForm do
  let(:form) { described_class.new(application:, **arguments) }

  let(:arguments) do
    {
      application:,
      other_info:,
      conclusion:,
      concluded:,
    }
  end

  let(:application) { instance_double(Claim, update!: true) }
  let(:other_info) { 'other relevent information' }

  describe '#save concluded yes' do
    context 'when all fields are set and concluded yes' do
      let(:concluded) { 'yes' }
      let(:conclusion) { 'conclusion' }

      it 'is valid' do
        expect(form.save).to be_truthy
        expect(application).to have_received(:update!)
        expect(form).to be_valid
      end
    end
  end

  describe '#save concluded no' do
    context 'when all fields are set' do
      let(:concluded) { 'no' }
      let(:conclusion) { '' }

      it 'is valid' do
        expect(form.save).to be_truthy
        expect(application).to have_received(:update!)
        expect(form).to be_valid
      end
    end
  end

  describe '#valid? with concluded yes' do
    context 'when all fields are set' do
      let(:concluded) { 'yes' }
      let(:conclusion) { 'conclusion' }

      it 'is valid' do
        expect(form).to be_valid
      end
    end
  end

  describe '#valid? with concluded no' do
    context 'when all fields are set' do
      let(:concluded) { 'no' }
      let(:conclusion) { '' }

      it 'is valid' do
        expect(form).to be_valid
      end
    end
  end
end
