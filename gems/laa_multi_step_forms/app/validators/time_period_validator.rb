class TimePeriodValidator < ActiveModel::EachValidator
  TIME_PERIOD_STRUCT = Struct.new('TIME_PERIOD_STRUCT', :hours, :minutes)

  attr_reader :record, :attribute, :config

  def initialize(options)
    super
    @config = options
  end

  def validate_each(record, attribute, value)
    # this will trigger a `:blank` error when `presence: true`
    return if value.blank?

    @record = record
    @attribute = attribute

    # If the value is a hash, we use a simple struct to keep a
    # consistent interface, similar to a real date object.
    # Remember, the hash will have the format: {3=>31, 2=>12, 1=>2000}
    # where `3` is the day, `2` is the month and `1` is the year.
    time_period =
      if value.is_a?(Hash)
        TIME_PERIOD_STRUCT.new(hours: value[1], minutes: value[2])
      else
        value
      end

    validate_period(time_period)
  end

  private

  def validate_period(time_period)
    add_error(:invalid_hour)   unless time_period.hours.to_i >= 0
    add_error(:invalid_minute) unless time_period.minutes.to_i.between?(0, 59)

    unless time_period.is_a?(Type::TimePeriod::Instance)
      # If, after all, we still don't have a valid date object, it means
      # there are additional errors, like June 31st, or day 29 in non-leap year.
      # We just add a generic error as it would be an overkill to set granular
      # errors for all the possible combinations.
      add_error(:invalid)
    end
  end

  def add_error(error)
    record.errors.add(attribute, error)
  end
end
