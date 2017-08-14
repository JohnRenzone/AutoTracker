require 'rails_helper'

RSpec.describe FluidLevel, type: :model do
  let(:fluid_level) { FactoryGirl.build(:fluid_level) }

  it { expect(fluid_level).to belong_to(:vehicle_report_card) }
end
