module Decisions
  class SimpleDecisionTree < BaseDecisionTree
    def destination
      case step_name
      when :claim_type
        after_claim_type
      when :firm_details
        edit(:case_disposal)
      else
        index('/claims')
      end
    end

    def after_claim_type
      if form_object.claim_type.supported?
        edit(:firm_details)
      when :firm_details
        edit(:reason_for_claim)
      when :reason_for_claim
        edit(:case_details)
      else
        index('/claims')
      end
    end
  end
end

