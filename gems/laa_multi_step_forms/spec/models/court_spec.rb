require 'rails_helper'

RSpec.describe LaaMultiStepForms::Court, type: :model do
  describe '.all' do
    subject(:all) { described_class.all }

    it 'returns required courts as expected' do
      digest_of_expected_court_names = '4cdc39a4fa9cfe2aeb4984fe1dbab5d1'

      expect(Digest::MD5.hexdigest(all.map(&:name).join)).to eq digest_of_expected_court_names
    end
  end
end