class TimePeriodValidator < ActiveModel::EachValidator
  TIME_PERIOD_STRUCT = Struct.new('TIME_PERIOD_STRUCT', :days, :hours, :minutes, :seconds)

  attr_reader :record, :attribute, :config

  DEFAULT_OPTION = {
    fields: %i[hours minutes]
  }
  def initialize(options)
    super
    @config = DEFAULT_OPTION.merge(options)
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
        struct = TIME_PERIOD_STRUCT.new
        opts = @config[:fields].each_with_index do |field, index|
          struct[field] = value[index + 1]
        end
        struct
      else
        value
      end

    validate_period(time_period)
  end

  private

  def validate_period(time_period)
    if @config[:fields].include?(:days)
      add_error(:blank_hours) if time_period.days.blank?
      add_error(:invalid_hours) unless time_period.days.to_i >= 0
    end
    if @config[:fields].include?(:hours)
      add_error(:blank_hours) if time_period.hours.blank?
      add_error(:invalid_hours) unless time_period.hours.to_i >= 0
      add_error(:invalid_hours) unless time_period.hours.to_i < 24 && @config[:fields].include?(:days)
    end
    if @config[:fields].include?(:minutes)
      add_error(:blank_minutes) if time_period.minutes.blank?
      add_error(:invalid_minutes) unless time_period.minutes.to_i >= 0
      add_error(:invalid_minutes) unless time_period.minutes.to_i < 60 && @config[:fields].include?(:hours)
    end
    if @config[:fields].include?(:seconds)
      add_error(:blank_seconds) if time_period.seconds.blank?
      add_error(:invalid_seconds) unless time_period.seconds.to_i.between?(0, 59)
    end

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
