class Claim < ApplicationRecord
  belongs_to :firm_office, optional: true
  belongs_to :solicitor, optional: true

  def reference
    'aaaaa'
  end

  def date
    representation_order_withdrawn_date || cntp_date
  end

  def short_id
    id.first(8)
  end
end
