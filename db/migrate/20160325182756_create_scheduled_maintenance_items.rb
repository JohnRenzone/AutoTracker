class CreateScheduledMaintenanceItems < ActiveRecord::Migration
  def change
    create_table :scheduled_maintenance_items do |t|
      t.belongs_to :vehicle_report_card, index: true
      t.boolean :the_works, default: false
      t.boolean :the_works_serviced, default: false

      t.boolean :oil_changes, default: false
      t.boolean :oil_changes_serviced, default: false

      t.boolean :tire_rotation, default: false
      t.boolean :tire_rotation_serviced, default: false

      t.boolean :multipoint_inspection, default: false
      t.boolean :multipoint_inspection_serviced, default: false

      t.boolean :fuel_filter, default: false
      t.boolean :fuel_filter_serviced, default: false

      t.boolean :engine_air_filter, default: false
      t.boolean :engine_air_filter_serviced, default: false

      t.boolean :engine_coolant_filter, default: false
      t.boolean :engine_coolant_filter_serviced, default: false

      t.boolean :transmission_fluid_filter, default: false
      t.boolean :transmission_fluid_filter_serviced, default: false

      t.boolean :cabin_air_filter, default: false
      t.boolean :cabin_air_filter_serviced, default: false

      t.boolean :spark_plugs, default: false
      t.boolean :spark_plugs_serviced, default: false

      t.float :km_scheduled_maintenance

      t.timestamps null: false
    end
  end
end
