require 'rails_helper'

RSpec.describe VehicleReportCard, type: :model do
  let(:vehicle_report_card) { FactoryGirl.build(:vehicle_report_card) }

  it { expect(vehicle_report_card).to belong_to(:user) }

  context 'aasm state' do
    it "initial state" do
      expect(FactoryGirl.build(:vehicle_report_card).aasm_state).to eq('to_be_reviewed')
    end

    it "should change to reviewed from to_be_reviewed" do
      vehicle_report_card = FactoryGirl.create(:vehicle_report_card)
      vehicle_report_card.review!

      expect(vehicle_report_card.reviewed?).to be_truthy
    end


    it "should not change to reviewed from reviewed" do
      vehicle_report_card = FactoryGirl.create(:vehicle_report_card)
      vehicle_report_card.review!

      expect { vehicle_report_card.review! }.to raise_error
    end
  end

  context 'validations' do
    it "vin with 17 digits sshould be valid" do
      FactoryGirl.build(:vehicle_report_card, vehicle_identification_number: 'XXXXXX').should_not be_valid
    end

    it "vin with 17 digits should be valid" do
      FactoryGirl.build(:vehicle_report_card).should be_valid
    end

    it "vin with 17 digits sshould be valid" do
      FactoryGirl.build(:vehicle_report_card, vehicle_identification_number: 'XXXXXX').should_not be_valid
    end
  end

  context '#after_create' do
    context '#notify_service_advisor' do
      it 'notifies service advisor' do
        technician = FactoryGirl.create(:technician)
        service_advisor = FactoryGirl.create(:service_advisor)

        expect { FactoryGirl.create(:vehicle_report_card, user: technician, service_advisor_id: service_advisor.id) }
            .to change { ActionMailer::Base.deliveries.count }.by(1)
      end

      it 'does not notifies service advisor if service advisor not present' do
        technician = FactoryGirl.create(:technician)

        expect { FactoryGirl.create(:vehicle_report_card, user: technician, service_advisor_id: nil) }
            .to change { ActionMailer::Base.deliveries.count }.by(0)
      end
      it 'does not notifies service advisor if other than technician creates report' do
        admin = FactoryGirl.create(:admin)
        technician = FactoryGirl.create(:technician)
        service_advisor = FactoryGirl.create(:service_advisor)

        expect { FactoryGirl.create(:vehicle_report_card, user: admin, technician_id: technician.id, service_advisor_id: service_advisor.id) }
            .to change { ActionMailer::Base.deliveries.count }.by(0)
      end
    end
  end

  context '#aasm_state_label_css_class' do
    it "should return bootstrap label class" do
      expect(FactoryGirl.build(:vehicle_report_card).aasm_state_label_css_class).to eq('label-danger')
    end
  end

  context 'when report card created by technician' do
    it "customer_email should be valid if present" do
      report_card = build(:vehicle_report_card, customer_email: FFaker::Internet.email)
      expect(report_card).to be_valid
      expect(report_card.errors[:customer_email].size).to eq(0)
    end

    it "customer_email should not to be valid if present" do
      report_card = build(:vehicle_report_card, customer_email: 'you@')
      expect(report_card).not_to be_valid
      expect(report_card.errors[:customer_email].size).to eq(1)
    end
  end

  context '#before_save' do
    context '#odometer' do
      it 'odometer value should be present' do
        @vehicle_report_card = VehicleReportCard.new
        vehicle_report_card.run_callbacks(:save) { false }
      end
    end
  end

  context '#email_report' do
    it 'send mail to customer and set the status to sent_to_cusotmer' do
      dealership = FactoryGirl.create(:dealership)
      technician = FactoryGirl.create(:technician, dealership: dealership)
      service_advisor = FactoryGirl.create(:service_advisor, dealership: dealership)
      @vehicle_report_card = FactoryGirl.create(:vehicle_report_card, user: technician, service_advisor_id: service_advisor.id, customer_email: generate(:email))
      @vehicle_report_card.review!

      expect { @vehicle_report_card.email_report('Hello World') }.to change { ActionMailer::Base.deliveries.count }.by(1)
      expect(@vehicle_report_card.sent_to_customer?).to be_truthy
    end
  end
end