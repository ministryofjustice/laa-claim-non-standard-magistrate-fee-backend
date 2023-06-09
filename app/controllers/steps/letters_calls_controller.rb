module Steps
  class LettersCallsController < Steps::BaseStepController
    def edit
      @form_object = LettersCallsForm.build(
        current_application
      )
    end

    def update
      update_and_advance(LettersCallsForm, as: :letters_calls)
    end

    private

    def decision_tree_class
      Decisions::SimpleDecisionTree
    end

    def additional_permitted_params
      %i[apply_letters_uplift apply_calls_uplift]
    end
  end
end
