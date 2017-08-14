class ChangecolumnInVehicleReportCard < ActiveRecord::Migration
  def up
    change_column :vehicle_report_cards, :odometer, :integer, limit: 8
  end

  def down
    change_column :vehicle_report_cards, :odometer, :decimal
  end
end
