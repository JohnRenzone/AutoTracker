FactoryGirl.define do
  factory :authentication do
    association :user, factory: :admin
    provider { %w[twitter facebook linkedin].sample }
    proid { SecureRandom.hex }
    token {
      t = SecureRandom.hex
      t[8] = '-'
      t
    }
  end
end
