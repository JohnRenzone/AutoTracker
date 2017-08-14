class UpdateColumnInVehicleCard < ActiveRecord::Migration
  def up
    change_column :vehicle_report_cards, :report_card_date, :datetime, :null => true
    change_column :vehicle_report_cards, :ro,:integer, :null => true
    change_column :vehicle_report_cards, :service_advisor, :string, :null => true
    change_column :vehicle_report_cards, :technician, :string, :null => true
    change_column :vehicle_report_cards, :name, :string, :null => true
    change_column :vehicle_report_cards, :email,:string, :null => true
  end

  def down
    change_column :vehicle_report_cards, :report_card_date, :date
  end
end
