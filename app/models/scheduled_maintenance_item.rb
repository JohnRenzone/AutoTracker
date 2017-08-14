class ScheduledMaintenanceItem < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :vehicle_report_card, :inverse_of => :scheduled_maintenance_item
  validates_presence_of :vehicle_report_card

  ITEMS = [[:oil_changes, :oil_changes_serviced],
           [:tire_rotation, :tire_rotation_serviced],
           [:multipoint_inspection, :multipoint_inspection_serviced],
           [:fuel_filter, :fuel_filter_serviced],
           [:engine_air_filter, :engine_air_filter_serviced],
           [:engine_coolant_filter, :engine_coolant_filter_serviced],
           [:transmission_fluid_filter, :transmission_fluid_filter_serviced],
           [:cabin_air_filter, :cabin_air_filter_serviced],
           [:spark_plugs, :spark_plugs_serviced]]
end
