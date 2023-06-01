module Tasks
  class OtherInfo < BaseTask
    def path
      edit_steps_other_infos_path(application)
    end

    def not_applicable?
      false
    end

    def can_start?
      fulfilled?(ClaimDetails)
    end

    def completed?
      Steps::OtherInfoForm.build(application).valid?
    end
  end
end
