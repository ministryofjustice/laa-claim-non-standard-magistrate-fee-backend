require 'steps/base_form_object'

module Steps
  class CaseTypeForm < Steps::BaseFormObject
    #attribute :claim_type, :value_object, source: ClaimType

    attribute :offence_date_committed, :multiparam_date
    attribute :ufn, :string
    attribute :main_offence, :string
    attribute :assigned_counsel, :boolean
    attribute :no_assigned_counsel, :boolean
    attribute :agent_instructed, :boolean
    attribute :remitted_to_magistrate, :boolean

    CaseType.values.each do |case_type|
      attribute case_type, :boolean
    end

    def choices
      CaseType.values
    end

    private

    def persist!
      application.update(
        attributes.merge(attributes_to_reset)
      )
    end

    def attributes_to_reset
      {
        'main_offence' => main_offence,
        'offence_date_committed' => offence_date_committed,
         'assigned_counsel' => assigned_counsel,
          'agent_instructed' => agent_instructed,
          'remitted_to_magistrate' => remitted_to_magistrate,
      }
    end

    def status_attributes
      if claim_type == ClaimType::SOMETHING_ELSE
        { 'status' => :abandoned }
      else
        {}
      end
    end
  end
end
