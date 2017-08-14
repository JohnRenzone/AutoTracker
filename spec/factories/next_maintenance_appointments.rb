FactoryGirl.define do
  factory :next_maintenance_appointment do
    appointment_date { DateTime.strptime('04/27/2016 2:31 PM', '%m/%d/%Y %H:%M %P').utc }
    service_description "Testing"
    price 5432
    vehicle_report_card
  end
end