class RenameColumnServiceManagerIdInReports < ActiveRecord::Migration
  def change
    rename_column :vehicle_report_cards, :service_manager_id, :service_advisor_id
  end
end
