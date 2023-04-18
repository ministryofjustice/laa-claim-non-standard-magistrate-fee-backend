module Decisions
  class BaseDecisionTree
    class InvalidStep < RuntimeError; end

    attr_reader :form_object, :step_name

    def initialize(form_object, as:)
      @form_object = form_object
      @step_name = as
    end

    def destination
      raise 'implement this action, in subclasses'
    end

    def current_application
      form_object.application
    end

    private

    # :nocov:
    def show(step_controller, params = {})
      url_options(step_controller, :show, params)
    end

    def edit(step_controller, params = {})
      url_options(step_controller, :edit, params)
    end

    def url_options(controller, action, params = {})
      { controller: controller, action: action, id: current_application }.merge(params)
    end
    # :nocov:
  end
end