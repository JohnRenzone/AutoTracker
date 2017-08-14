require "rails_helper"

RSpec.describe VehicleReportCardMailer, type: :mailer do

  describe '#email_report_card' do
    before(:each) do
      ActionMailer::Base.delivery_method = :test
      ActionMailer::Base.perform_deliveries = true
      ActionMailer::Base.deliveries = []
      ActionMailer::Base.attachments['report.pdf'] = 'Hello World'
      @vehicle_report_card = FactoryGirl.create(:vehicle_report_card)
      @dealership = create(:dealership)
    end

    after(:each) do
      ActionMailer::Base.deliveries.clear
    end

    it 'should send mail when the dealership is known' do

      VehicleReportCardMailer.email_report_card(@vehicle_report_card, 'Hello World', @dealership).deliver_now

      ActionMailer::Base.deliveries.count eq(1)
      ActionMailer::Base.deliveries.first.to eq(@vehicle_report_card.customer_email)
      ActionMailer::Base.deliveries.first.subject.should eq("#{@dealership.title} - Your Vehicle Service Report #{I18n.l(Time.zone.now, format: :date_only)}")
      ActionMailer::Base.deliveries.first.from eq('support@autotracker.com')
      ActionMailer::Base.attachments.to eq(1)
    end

    it 'should send mail when the dealership is unknown' do

      VehicleReportCardMailer.email_report_card(@vehicle_report_card, 'Hello World', nil).deliver_now

      ActionMailer::Base.deliveries.count eq(1)
      ActionMailer::Base.deliveries.first.to eq(@vehicle_report_card.customer_email)
      ActionMailer::Base.deliveries.first.subject.should eq("Autotracker - Your Vehicle Service Report #{I18n.l(Time.zone.now, format: :date_only)}")
      ActionMailer::Base.deliveries.first.from eq('support@autotracker.com')
      ActionMailer::Base.attachments.to eq(1)
    end
  end

  describe '#notify_service_advisor' do
    let(:vehicle_report_card) { create(:vehicle_report_card, user: create(:technician), service_advisor_id: create(:service_advisor).id) }

    let(:mail) { described_class.notify_service_advisor(vehicle_report_card).deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eq("[AutoTracker] #{vehicle_report_card.vehicle_identification_number} Report has been Submitted")
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([vehicle_report_card.service_advisor.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq([Rails.application.config.settings.mail.from])
    end

    it 'assigns @name' do
      expect(mail.body.encoded).to match(vehicle_report_card.service_advisor.display_name)
    end
  end
end