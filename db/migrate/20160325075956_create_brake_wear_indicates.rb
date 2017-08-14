class CreateBrakeWearIndicates < ActiveRecord::Migration
  def change
    create_table :brake_wear_indicates do |t|
      t.belongs_to :vehicle_report_card, index: true
      t.float :left_front_brake_lining
      t.string :left_front_legend
      t.boolean :left_front_serviced, default: false
      t.float :left_rear_brake_lining
      t.string :left_rear_legend
      t.boolean :left_rear_serviced, default: false
      t.float :right_front_brake_lining
      t.string :right_front_legend
      t.boolean :right_front_serviced, default: false
      t.float :right_rear_brake_lining
      t.string :right_rear_legend
      t.boolean :right_rear_serviced, default: false

      t.timestamps null: false
    end
  end
end
