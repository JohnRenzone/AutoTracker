class ChangeColumnName < ActiveRecord::Migration
  def change
    remove_column :vehicle_report_cards, :technician, :string
    add_column :vehicle_report_cards, :technician_id, :integer
  end
end
