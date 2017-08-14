require 'rails_helper'

RSpec.describe NextMaintenanceAppointment, type: :model do
  let(:next_maintenance_appointment) { FactoryGirl.build(:next_maintenance_appointment) }

  it do
    expect(next_maintenance_appointment).to belong_to(:vehicle_report_card)
  end
end
