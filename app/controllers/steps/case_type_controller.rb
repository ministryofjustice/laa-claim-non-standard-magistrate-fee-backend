module Steps
  class CaseTypeController < Steps::BaseStepController
    def edit
      @form_object = CaseTypeForm.build(
        current_application
      )
    end

    def update
      update_and_advance(CaseTypeForm, as: :firm_details)
    end

    private

    def decision_tree_class
      Decisions::SimpleDecisionTree
    end
  end
end
