class ChangeFieldsInVehicleReportCard < ActiveRecord::Migration
  def change
    change_column :vehicle_report_cards, :make,  :string
    change_column :vehicle_report_cards, :model,  :string
    remove_column :vehicle_report_cards, :exterior_body_note
    add_column :vehicle_report_cards, :attachment, :string
  end
end
