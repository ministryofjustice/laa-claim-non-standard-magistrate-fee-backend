class Claim < ApplicationRecord
  belongs_to :firm_office, optional: true
  belongs_to :solicitor, optional: true
  has_many :defendants, -> { order(:position) }, dependent: :destroy, inverse_of: :claim
  has_many :work_items, -> { order(:completed_on, :work_type, :id) }, dependent: :destroy, inverse_of: :claim
  has_many :disbursements, lambda {
                             order(:disbursement_date, :disbursement_type, :id)
                           }, dependent: :destroy, inverse_of: :claim
  has_many :evidence_upload, -> { order(:upload_date) }, dependent: :destroy, inverse_of: :claim
  has_many_attached :evidence

  def date
    rep_order_date || cntp_date
  end

  def short_id
    id.first(8)
  end
end
