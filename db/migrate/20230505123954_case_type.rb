class CaseType < ActiveRecord::Migration[7.0]
  def change
    add_column :claims, :main_offence, :text
    add_column :claims, :offence_date_committed, :date
    add_column :claims, :assigned_counsel, :bool
    add_column :claims, :no_assigned_counsel, :bool
    add_column :claims, :unassigned_counsel, :bool
    add_column :claims, :no_unassigned_counsel, :bool
    add_column :claims, :agent_instructed, :bool
    add_column :claims, :no_agent_instructed, :bool
    add_column :claims, :remitted_to_magistrate, :bool
  end
end
