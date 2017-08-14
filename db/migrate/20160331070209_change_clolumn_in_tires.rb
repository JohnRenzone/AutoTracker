class ChangeClolumnInTires < ActiveRecord::Migration
  def up
    change_column :tire_wear_indicates, :left_front_tread_depth, :integer
    change_column :tire_wear_indicates, :right_front_tread_depth, :integer
    change_column :tire_wear_indicates, :left_rear_tread_depth, :integer
    change_column :tire_wear_indicates, :right_rear_tread_depth, :integer
  end

  def down
    change_column :tire_wear_indicates, :left_front_tread_depth, :decimal
    change_column :tire_wear_indicates, :right_front_tread_depth, :decimal
    change_column :tire_wear_indicates, :left_rear_tread_depth, :decimal
    change_column :tire_wear_indicates, :right_rear_tread_depth, :decimal
  end
end
