require 'rails_helper'

RSpec.describe CaseDetails do
  subject { described_class.new(value) }

  let(:value) { :foo }

  describe '.values' do
    it 'returns all possible values' do
      expect(described_class.values.map(&:to_s)).to eq(
        %w[
          assigned_counsel
          unassigned_counsel
          agent_instructed
          remitted_to_magistrate
        ]
      )
    end
  end
  
  describe 'helper methods' do
    it 'returns has_date_field' do
      expect(described_class.values[3].has_date_field?).to eq(true)
    end       
  end

  describe 'helper methods' do
    it 'returns date_field_name' do
      expect(described_class.values[3].date_field_name).to eq("representation_order_withdrawn_date")
    end       
  end
end
