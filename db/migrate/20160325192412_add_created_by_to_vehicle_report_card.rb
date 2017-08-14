class AddCreatedByToVehicleReportCard < ActiveRecord::Migration
  def change
    add_reference :vehicle_report_cards, :user, index: true
  end
end
