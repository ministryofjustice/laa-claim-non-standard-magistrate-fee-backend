module Steps
  class ClaimDetailsController < Steps::BaseStepController
    def edit
      @form_object = ClaimDetailsForm.build(
        current_application
      )
    end

    def update
      update_and_advance(ClaimDetailsForm, as: :claim_details)
    end

    private

    def decision_tree_class
      Decisions::SimpleDecisionTree
    end
  end
end