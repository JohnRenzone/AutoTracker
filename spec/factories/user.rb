FactoryGirl.define do
  sequence(:username) { |n| "username#{n}" }
  sequence(:email) { |n| "test#{n}@example.com" }

  factory :user do
    email
    first_name  { FFaker::Name.first_name }
    last_name   { FFaker::Name.last_name }
    password    { FFaker::DizzleIpsum.words(4).join('!').first(20) }

    factory :admin do
      role 0
    end

    factory :dealer do
      role 1
      dealership
    end

    factory :service_advisor do
      role 2
      dealership
    end

    factory :technician do
      username
      email nil
      role 3
      dealership
    end
  end
end
