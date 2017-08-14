class ChangeColumnInNextAppointment < ActiveRecord::Migration
  def change
    change_column :next_maintenance_appointments, :appointment_date, :datetime
  end
end
