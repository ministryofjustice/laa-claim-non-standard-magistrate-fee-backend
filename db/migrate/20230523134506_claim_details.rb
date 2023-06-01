class ClaimDetails < ActiveRecord::Migration[7.0]
  def change
    add_column :claims, :prosecution_evidence, :string
    add_column :claims, :defence_statement, :string
    add_column :claims, :number_of_witnesses, :integer
    add_column :claims, :supplemental_claim, :string
    add_column :claims, :preparation_time, :string
    add_column :claims, :time_spent_hours, :integer
    add_column :claims, :time_spent_mins, :integer
    add_column :claims, :other_info, :string
    add_column :claims, :conclusion, :string
    add_column :claims, :conclusion_yes, :string
    add_column :claims, :conclusion_no, :string
  end
end
