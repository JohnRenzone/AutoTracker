class CreateTireWearIndicates < ActiveRecord::Migration
  def change
    create_table :tire_wear_indicates do |t|
      t.belongs_to :vehicle_report_card, index: true
      t.boolean :alignment_check_needed, default: false
      t.boolean :wheel_balance_needed, default: false

      t.float :left_front_tread_depth
      t.string :left_front_tread_depth_legend
      t.boolean :left_front_tread_depth_serviced, default: false
      t.string :left_front_pattern_legend
      t.boolean :left_front_pattern_serviced, default: false
      t.string :left_front_psi_legend
      t.boolean :left_front_psi_serviced, default: false
      t.float :left_front_tire_age

      t.float :left_rear_tread_depth
      t.string :left_rear_tread_depth_legend
      t.boolean :left_rear_tread_depth_serviced, default: false
      t.string :left_rear_pattern_legend
      t.boolean :left_rear_pattern_serviced, default: false
      t.string :left_rear_psi_legend
      t.boolean :left_rear_psi_serviced, default: false
      t.float :left_rear_tire_age

      t.float :right_front_tread_depth
      t.string :right_front_tread_depth_legend
      t.boolean :right_front_tread_depth_serviced, default: false
      t.string :right_front_pattern_legend
      t.boolean :right_front_pattern_serviced, default: false
      t.string :right_front_psi_legend
      t.boolean :right_front_psi_serviced, default: false
      t.float :right_front_tire_age

      t.float :right_rear_tread_depth
      t.string :right_rear_tread_depth_legend
      t.boolean :right_rear_tread_depth_serviced, default: false
      t.string :right_rear_pattern_legend
      t.boolean :right_rear_pattern_serviced, default: false
      t.string :right_rear_psi_legend
      t.boolean :right_rear_psi_serviced, default: false
      t.float :right_rear_tire_age

      t.float :spare_tire_age
      t.string :spare_tire_psi_legend
      t.boolean :spare_tire_serviced, default: false


      t.timestamps null: false
    end
  end
end
