require 'steps/base_form_object'

module Steps
  class EvidenceUploadForm < Steps::BaseFormObject
    attribute :evidence_uploads, :string

    private

    def persist!
      application.update!(attributes)
    end
  end
end