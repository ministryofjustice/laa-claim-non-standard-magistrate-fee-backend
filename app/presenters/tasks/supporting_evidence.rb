# frozen_string_literal: true
module Tasks
  class SupportingEvidence < Generic
    PREVIOUS_TASK = OtherInfo
    FORM = Steps::SupportingEvidence

    def path
      edit_steps_supporting_evidence_path(application)
    end

    def completed?
      Steps::SupportingEvidence.build(application).valid?
    end
  end
end