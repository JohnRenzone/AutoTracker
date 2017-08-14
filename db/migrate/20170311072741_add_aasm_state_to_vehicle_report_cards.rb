class AddAasmStateToVehicleReportCards < ActiveRecord::Migration
  def change
    add_column :vehicle_report_cards, :aasm_state, :string

    VehicleReportCard.update_all "aasm_state = 'to_be_reviewed'"
  end
end
