require 'rails_helper'

RSpec.describe 'User can see cost breakdowns', type: :system do
  let(:claim) { create(:claim, :letters_calls, work_items:, disbursements:) }
  let(:work_items) do
    [
      build(:work_item, :attendance_without_counsel, time_spent: 90),
      build(:work_item, :advocacy, time_spent: 104),
      build(:work_item, :advocacy, time_spent: 86),
    ]
  end
  let(:disbursements) do
    [
      build(:disbursement, :valid, :car, age: 5, miles: 200),
      build(:disbursement, :valid_other, :dna_testing, age: 4, total_cost_without_vat: 30),
      build(:disbursement, :valid_other, age: 3, other_type: 'Custom', total_cost_without_vat: 40),
      build(:disbursement, :valid, :car, age: 2, miles: 150),
    ]
  end

  before do
    visit provider_saml_omniauth_callback_path
  end

  it 'can do green path' do
    visit steps_cost_summary_path(claim.id)

    doc = Nokogiri::HTML(page.html)
    values = doc.css('.govuk-summary-card h2, dd, dt').map(&:text)

    expect(values).to eq(
      [
        'Work items total £260.68',
        'Items', 'Total per item',
        'Attendance without counsel', '£53.52', # 35.68 * 90 / 60
        'Preparation', '£',
        'Advocacy', '£207.16', # 65.42 * (104 + 86) / 60
        'Total', '£260.68',

        'Letters and phone calls total £20.45',
        'Items', 'Total per item',
        'Letters', '£8.18', # 4.09 * 2
        'Phone calls', '£12.27', # 4.09 * 3
        'Total', '£20.45',

        'Disbursements total £227.50',
        'Items', 'Total per item',
        'Car', '£90.00', # 200 * 0.45
        'DNA Testing', '£30.00',
        'Custom', '£40.00',
        'Car', '£67.50', # 150 * 0.45
        'Total', '£227.50'
      ]
    )
  end
end
