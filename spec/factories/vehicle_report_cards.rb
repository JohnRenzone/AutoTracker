FactoryGirl.define do
  factory :vehicle_report_card do
    vehicle_identification_number { generate(:vin) }
    odometer 4
    association :user, factory: :technician
    customer_email   { FFaker::Internet.email }
  end
end
