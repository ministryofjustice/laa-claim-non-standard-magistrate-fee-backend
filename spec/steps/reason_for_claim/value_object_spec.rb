require 'rails_helper'

RSpec.describe ReasonForClaim do
  subject { described_class.new(value) }

  let(:value) { :foo }

  describe '.values' do
    it 'returns all possible values' do
      expect(described_class.values.map(&:to_s)).to eq(
        %w[
          core_costs_exceed_higher_limit,
          enhanced_rates_claimed,
          counsel_or_agent_assigned,
          representation_order_withdrawn,
          extradition,
          other,
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
