module Decisions
  class SimpleDecisionTree < BaseDecisionTree
    def destination
      case step_name
      when :claim_type
        edit(:firm_details)
      when :firm_details
        edit(:case_details)
      when :case_details
        edit(:case_disposal)
      else
        index(:'/claims')
      end
    end
  end
end

