require 'rails_helper'

RSpec.describe WiperBlade, type: :model do
  let(:wiper_blade) { FactoryGirl.build(:wiper_blade) }

  it { expect(wiper_blade).to belong_to(:vehicle_report_card) }
end
