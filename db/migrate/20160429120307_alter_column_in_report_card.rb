class AlterColumnInReportCard < ActiveRecord::Migration
  def change
    change_column :vehicle_report_cards, :odometer, :integer, limit: 8, :null => true
  end
end
