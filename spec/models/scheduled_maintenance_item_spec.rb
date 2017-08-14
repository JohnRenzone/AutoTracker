require 'rails_helper'

RSpec.describe ScheduledMaintenanceItem, type: :model do
  let(:scheduled_maintenance_item) { FactoryGirl.build(:scheduled_maintenance_item) }

  it { expect(scheduled_maintenance_item).to belong_to(:vehicle_report_card) }
end
