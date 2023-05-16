module Tasks
  class CaseDisposal < BaseTask
    def path
      edit_steps_case_disposal_path
    end

    def not_applicable?
      false
    end

    def can_start?
      # TODO: update this to CaseDetails once implemented
      fulfilled?(FirmDetails)
    end

    def in_progress?
      false
    end

    def completed?
      !application.plea.nil?
    end
  end
end
