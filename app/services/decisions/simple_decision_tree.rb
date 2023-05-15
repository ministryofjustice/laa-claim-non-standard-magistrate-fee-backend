module Decisions
  class SimpleDecisionTree < BaseDecisionTree
    def destination
      case step_name
      when :claim_type
        edit(:firm_details)
      when :firm_details
        edit(:reason_for_claim)
      when :reason_for_claim
        edit(:case_details)
      else
        edit(:claims)
      end
    end
  end
end

