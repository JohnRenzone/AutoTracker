require 'rails_helper'

RSpec.describe TireWearIndicate, type: :model do
  let(:tire_wear_indicate) { FactoryGirl.build(:tire_wear_indicate) }

  it { expect(tire_wear_indicate).to belong_to(:vehicle_report_card) }
end
