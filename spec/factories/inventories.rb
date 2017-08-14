FactoryGirl.define do
  sequence(:data_one_vehicle_id) { |n| n }

  sequence(:vin) { |n| "#{n}".rjust(17, '0') }

  factory :inventory do
    vin
    data_one_vehicle_id
  end
end
