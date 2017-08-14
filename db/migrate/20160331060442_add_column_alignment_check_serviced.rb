class AddColumnAlignmentCheckServiced < ActiveRecord::Migration
  def change
    add_column :tire_wear_indicates, :alignment_check_serviced, :boolean
    add_column :tire_wear_indicates, :wheel_balance_serviced, :boolean
  end
end
