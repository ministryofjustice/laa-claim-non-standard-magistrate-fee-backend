require 'steps/base_form_object'

module Steps
  class OtherInfoForm < Steps::BaseFormObject
    BOOLEAN_FIELDS = %i[conclusion_yes conclusion_no].freeze

    attribute :other_info, :string
    attribute :conclusion, :string
   
    validates :other_info, presence: true
    validates :conclusion, presence: true
    validates :number_of_witnesses, presence: true, numericality: { only_integer: true, greater_than: 0 }

    BOOLEAN_FIELDS.each do |field|
      validates field, presence: true, inclusion: { in: YesNoAnswer.values }
      attribute field, :value_object, source: YesNoAnswer
    end

    def boolean_fields
      self.class::BOOLEAN_FIELDS
    end

    private

    def persist!

      application.update!(attributes)
    end
  end
end
