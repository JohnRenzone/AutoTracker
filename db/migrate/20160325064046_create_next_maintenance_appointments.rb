class CreateNextMaintenanceAppointments < ActiveRecord::Migration
  def change
    create_table :next_maintenance_appointments do |t|
      t.string :service_description
      t.date :appointment_date
      t.decimal :price
      t.time :appointment_time
      t.belongs_to :vehicle_report_card, index: true
      t.timestamps null: false
    end
  end
end
