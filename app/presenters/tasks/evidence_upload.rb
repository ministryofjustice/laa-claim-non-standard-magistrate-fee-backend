module Tasks
  class EvidenceUpload < Generic
    PREVIOUS_TASK = OtherInfo
    FORM = Steps::EvidenceUploadForm

    def path
      edit_steps_evidence_upload_path(application)
    end

    def completed?
      Steps::EvidenceUploadForm.build(application).valid?
    end
  end
end