class NextMaintenanceAppointment < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :vehicle_report_card, :inverse_of => :next_maintenance_appointment
  validates_presence_of :vehicle_report_card
end
