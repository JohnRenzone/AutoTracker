class CreateVehicleComponents < ActiveRecord::Migration
  def change
    create_table :vehicle_components do |t|
      t.belongs_to :vehicle_report_card, index: true
      t.string :light_legend
      t.boolean :light_serviced, default: false
      t.string :windshield_legend
      t.boolean :windshield_serviced, default: false

      t.string :hvac_system_hoses_legend
      t.boolean :hvac_system_hoses_serviced, default: false
      t.string :engine_cooling_legend
      t.boolean :engine_cooling_serviced, default: false
      t.string :accessory_drive_belts_legend
      t.boolean :accessory_drive_belts_serviced, default: false

      t.string :brake_system_legend
      t.boolean :brake_system_serviced, default: false

      t.string :suspension_legend
      t.boolean :suspension_serviced, default: false
      t.string :steering_legend
      t.boolean :steering_serviced, default: false

      t.string :exhaust_system_legend
      t.boolean :exhaust_system_legend, default: false

      t.string :clutch_legend
      t.boolean :clutch_legend_serviced, default: false
      t.string :constant_velocity_legend
      t.boolean :constant_velocity_serviced, default: false
      t.string :drive_shaft_legend
      t.boolean :drive_shaft_serviced, default: false

      t.timestamps null: false
    end
  end
end
