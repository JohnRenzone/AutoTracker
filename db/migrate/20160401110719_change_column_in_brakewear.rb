class ChangeColumnInBrakewear < ActiveRecord::Migration
  def change
    change_column :brake_wear_indicates, :left_front_brake_lining, :integer
    change_column :brake_wear_indicates, :left_rear_brake_lining, :integer
    change_column :brake_wear_indicates, :right_front_brake_lining, :integer
    change_column :brake_wear_indicates, :right_rear_brake_lining, :integer
  end
end
