class RemoveNullConstraint < ActiveRecord::Migration
  def change
    change_column :vehicle_report_cards, :odometer, :integer, :null => true
  end
end
