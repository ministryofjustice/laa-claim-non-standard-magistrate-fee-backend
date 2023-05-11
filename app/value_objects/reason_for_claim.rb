class ReasonForClaim < ValueObject
  VALUES = [
    CORE_COSTS_EXCEED_HIGHER_LMTS = new(:core_costs_exceed_higher_limit),
    ENHANCED_RATES_CLAIMED    = new(:enhanced_rates_claimed),
    counsel_OR_AGENT_ASSIGNED = new(:counsel_or_agent_assigned),
    REPRESENTATION_ORDER_WITHDRAWN = new(:representation_order_withdrawn),
    EXTRADITION = new(:extradition),
    OTHER = new(:other),
  #REASON_FOR_CLAIM_OTHER = new(:reason_for_claim_other),
  ].freeze

  def date_field_name()
    "#{value}_date"
  end

  def has_date_field?()
    self == REPRESENTATION_ORDER_WITHDRAWN
  end
end
