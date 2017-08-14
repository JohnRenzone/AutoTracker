require 'rails_helper'

RSpec.describe BrakeWearIndicate, type: :model do
  let(:brake_wear_indicate) { FactoryGirl.build(:brake_wear_indicate) }

  it { expect(brake_wear_indicate).to belong_to(:vehicle_report_card) }
end
