require 'rails_helper'

RSpec.describe Battery, type: :model do
  let(:battery) { FactoryGirl.build(:battery) }

  it { expect(battery).to belong_to(:vehicle_report_card) }
end
