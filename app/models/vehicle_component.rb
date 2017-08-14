class VehicleComponent < ActiveRecord::Base
  acts_as_paranoid
  
  belongs_to :vehicle_report_card

  ITEMS = {"LIGHTS/WINDSHIELD" => [[:light_legend, :light_serviced, [:yellow]],
                                   [:windshield_legend, :windshield_serviced, [:yellow]]],
           "BELTS/HOSES/MOUNTS" => [[:hvac_system_hoses_legend, :hvac_system_hoses_serviced],
                                    [:engine_cooling_legend, :engine_cooling_serviced],
                                    [:accessory_drive_belts_legend, :accessory_drive_belts_serviced]],
           "BRAKE SYSTEM" => [[:brake_system_legend, :brake_system_serviced]],
           "STEERING/SUSPENSION" => [[:suspension_legend, :suspension_serviced],
                                     [:steering_legend, :steering_serviced]],
           "EXHAUST SYSTEM" => [[:exhaust_system_legend, :exhaust_system_serviced]],
           "TRANSMISSION/DRIVE AXLE" => [[:clutch_legend, :clutch_legend_serviced],
                                         [:constant_velocity_legend, :constant_velocity_serviced],
                                         [:drive_shaft_legend, :drive_shaft_serviced]]}
end
