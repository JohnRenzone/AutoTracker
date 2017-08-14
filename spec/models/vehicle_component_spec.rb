require 'rails_helper'

RSpec.describe VehicleComponent, type: :model do
  let(:vehicle_component) { FactoryGirl.build(:vehicle_component) }

  it { expect(vehicle_component).to belong_to(:vehicle_report_card) }
end
