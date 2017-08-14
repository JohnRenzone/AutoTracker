FactoryGirl.define do
  factory :dealership do
    title FFaker::Name.first_name
  end
end
