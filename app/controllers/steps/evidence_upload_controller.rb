module Steps
  class EvidenceUploadController < Steps::BaseStepController
    def edit
      @form_object ||= EvidenceUploadForm.build(current_application)
      @files ||= EvidenceUpload.find_by claim_id: current_application.id
    end

    def update
      update_and_advance(EvidenceUploadForm, as: :evidence_upload)
    end
  end
end
