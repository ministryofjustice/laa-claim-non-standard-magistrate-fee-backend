# TODO: work out how to make this wokr for different combinations
# i.e. days/hours/minutes hours/minutes or hours//minutes/seconds
# most likely need a Instance for each set based on want is paased
# into the config....

module Type
  class TimePeriod < ActiveModel::Type::Integer
    class Instance < SimpleDelegator
      def initialize(value, fields:)
        @fields = fields
        super(value)
      end

      THINGS = {
        days: [24, nil],
        hours: [60, 24],
        minutes: [60, 60],
        seconds: [60, 1]
      }


      def days
        process(:days)
      end

      def hours
        process(:hours)
      end

      def minutes
        process(:minutes)
      end

      def seconds
        process(:seconds)
      end

      # helper method that can be checked with `.try?(:valid?)` to determine
      # is the instance was correct instantiated
      def valid?
        true
      end

      private

      def process(field)
        return nil unless @fields.include?(field)

        things = THINGS.slice(*@fields)
        if field == things.keys.first
            # last value type so we can skip the modular call
          field_value(field)
        else
          field_value(field) % things[field][1]
        end
      end

      def field_value(field)
        things = THINGS.slice(*@fields)
        start_pos = things.map(&:first).index(field)
        # last value is always one so we can skip
        things.values[start_pos..-2].inject(__getobj__) do |value, (divisor, _)|
          value / divisor
        end
      end
    end

    def initialize(*args, **kwargs)
      @fields = kwargs.delete(:fields)
      super
    end

    # Used to coerce a Rails multi parameter date into a standard date,
    # with some light validation to not end up with wrong dates or
    # raising exceptions. Additional validation is performed in the
    # form object through the validators.
    #
    def cast(value)
      if value.is_a?(Hash)
        value_args = value.values_at(1, 2)
        if valid_period?(*value_args)
          Instance.new(value_args[0].to_i * 60 + value_args[1].to_i, fields: @fields)
        else
          # This is not a valid period, but we return the hash so we perform
          # more granular validation in the form object and can render the
          # view with the errors and whatever values the user entered.
          value
        end
      else
        # when it is an integer
        Instance.new(value, fields: @fields)
      end
    end

    def serialize(value)
      value
    end


    def valid_period?(hours, minutes)
      hours.to_s =~ /\A\d+\z/ && hours.to_i > 0 &&
       minutes.to_s =~ /\A\d+\z/ && (0..59).include?(minutes.to_i)
    end
  end
end
