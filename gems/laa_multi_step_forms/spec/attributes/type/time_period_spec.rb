require 'rails_helper'

RSpec.describe Type::TimePeriod do
  describe 'when hours and minutes' do
    it 'returns the expected values' do
      value = Type::TimePeriod.new(fields: %i[hours minutes]).cast(100)
      expect(value).to have_attributes(
        days: nil,
        hours: 1,
        minutes: 40,
        seconds: nil
      )
    end

    it 'when over a day in length' do
      value = Type::TimePeriod.new(fields: %i[hours minutes]).cast(25 * 60 + 10)
      expect(value).to have_attributes(
        days: nil,
        hours: 25,
        minutes: 10,
        seconds: nil
      )
    end

    it 'when under and hour' do
      value = Type::TimePeriod.new(fields: %i[hours minutes]).cast(10)
      expect(value).to have_attributes(
        days: nil,
        hours: 0,
        minutes: 10,
        seconds: nil
      )
    end
  end
end