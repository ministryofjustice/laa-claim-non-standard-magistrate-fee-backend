# frozen_string_literal: true

class EvidenceUpload < ApplicationRecord
  belongs_to :claim
  has_one_attached :file
end
