class CreateFluidLevels < ActiveRecord::Migration
  def change
    create_table :fluid_levels do |t|
      t.belongs_to :vehicle_report_card, index: true
      t.boolean :fluid_levels_serviced, default: false
      t.string :engine_oil
      t.string :brake_reservoir
      t.string :power_steering
      t.string :window_washer
      t.string :transmission
      t.string :coolent_recovery_reservoir
      t.timestamps null: false
    end
  end
end
