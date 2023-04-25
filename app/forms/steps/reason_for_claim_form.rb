require 'steps/base_form_object'

module Steps
  class ReasonForClaimForm < Steps::BaseFormObject
    attribute :reason_for_claim, :value_object, source: ReasonForClaim
    attribute :core_costs_exceed_higher_limit, :boolean
    attribute :enhanced_rates_claimed, :boolean
    attribute :counsel_or_agent_assigned, :boolean
    attribute :representation_order_withdrawn, :boolean
    attribute :extradition, :boolean
    attribute :other, :boolean
    attribute :representation_order_withdrawn_date, :multiparam_date
    attribute :reason_for_claim_other, :string

    ReasonForClaim.values.each do |reason_for_claim|
      attribute reason_for_claim, :boolean
    end

    validate :validate_reasons

    def choices
      ReasonForClaim.values
    end

    # def persist!
    #  application.update(
    #    attributes.merge(attributes_to_reset)
    #  )
    # end

    def attributes_to_reset
      {
        'core_costs_exceed_higher_limit' => core_costs_exceed_higher_limit,
        'enhanced_rates_claimed' => enhanced_rates_claimed,
        'counsel_or_agent_assigned' => counsel_or_agent_assigned,
        'representation_order_withdrawn' => representation_order_withdrawn,
        'representation_order_withdrawn_date' => representation_order_withdrawn_date,
        'extradition' => extradition,
        'other' => other,
        'reason_for_claim_other' => reason_for_claim_other,
      }
    end

    def validate_reasons
      if (core_costs_exceed_higher_limit.nil? &&
        enhanced_rates_claimed.nil? &&
        counsel_or_agent_assigned.nil? &&
        representation_order_withdrawn.nil? &&
        extradition.nil? &&
        other.nil?)
        errors.add(attribute_name, :invalid)
        return true
      end
    end

    def persist!
      application.update(attributes)
    end
  end
end
