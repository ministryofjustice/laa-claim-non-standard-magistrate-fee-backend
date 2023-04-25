module Tasks
  class CaseDetails < BaseTask
    def path
      edit_steps_case_details_path
    end

    def not_applicable?
      false
    end

    def can_start?
      fulfilled?(FirmDetails)
    end

    def in_progress?
      application.navigation_stack.include?(path)
    end

    def completed?
      application.values_at(*Steps::CaseDetailsForm.attribute_names).all?(&:present?)
    end
  end
end
