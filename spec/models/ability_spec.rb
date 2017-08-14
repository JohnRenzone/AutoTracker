require 'rails_helper'
require "cancan/matchers"

describe "Autotracker" do
  describe "abilities" do
    describe 'admin' do
      subject(:ability) { Ability.new(user) }
      let(:user) { FactoryGirl.create(:admin) }

      it { should be_able_to(:index, FactoryGirl.create(:dealership)) }
      it { should be_able_to(:new, FactoryGirl.create(:dealership)) }
      it { should be_able_to(:create, FactoryGirl.create(:dealership)) }
      it { should be_able_to(:show, FactoryGirl.create(:dealership)) }
      it { should be_able_to(:edit, FactoryGirl.create(:dealership)) }
      it { should be_able_to(:update, FactoryGirl.create(:dealership)) }
      it { should be_able_to(:destroy, FactoryGirl.create(:dealership)) }


      it { should be_able_to(:index, FactoryGirl.create(:admin)) }
      it { should be_able_to(:new, FactoryGirl.create(:admin)) }
      it { should be_able_to(:create, FactoryGirl.create(:admin)) }
      it { should be_able_to(:show, FactoryGirl.create(:admin)) }
      it { should be_able_to(:edit, FactoryGirl.create(:admin)) }
      it { should be_able_to(:update, FactoryGirl.create(:admin)) }
      it { should be_able_to(:destroy, FactoryGirl.create(:admin)) }
      it { should_not be_able_to(:login, User) }
      it { should_not be_able_to(:login_as, FactoryGirl.create(:admin)) }
      it { should_not be_able_to(:login_as, FactoryGirl.create(:dealer)) }
      it { should_not be_able_to(:login_as, FactoryGirl.create(:service_advisor)) }
      it { should_not be_able_to(:login_as, FactoryGirl.create(:technician)) }

      it { should be_able_to(:index, FactoryGirl.create(:vehicle_report_card)) }
      it { should_not be_able_to(:new, FactoryGirl.create(:vehicle_report_card)) }
      it { should_not be_able_to(:create, FactoryGirl.create(:vehicle_report_card)) }
      it { should be_able_to(:show, FactoryGirl.create(:vehicle_report_card)) }
      it { should be_able_to(:edit, FactoryGirl.create(:vehicle_report_card)) }
      it { should_not be_able_to(:update, FactoryGirl.create(:vehicle_report_card)) }
      it { should_not be_able_to(:destroy, FactoryGirl.create(:vehicle_report_card)) }
      it { should_not be_able_to(:send_pdf, FactoryGirl.create(:vehicle_report_card)) }
      it { should_not be_able_to(:email_pdf, FactoryGirl.create(:vehicle_report_card)) }
    end
  end

  describe 'dealer' do
    subject(:ability) { Ability.new(user) }
    let(:user) { FactoryGirl.create(:dealer) }
    let(:technician) { FactoryGirl.create(:technician, dealership: user.dealership) }

    it { should_not be_able_to(:index, FactoryGirl.create(:dealership)) }
    it { should_not be_able_to(:new, FactoryGirl.create(:dealership)) }
    it { should_not be_able_to(:create, FactoryGirl.create(:dealership)) }
    it { should_not be_able_to(:show, FactoryGirl.create(:dealership)) }
    it { should_not be_able_to(:edit, FactoryGirl.create(:dealership)) }
    it { should_not be_able_to(:update, FactoryGirl.create(:dealership)) }
    it { should_not be_able_to(:destroy, FactoryGirl.create(:dealership)) }


    it { should be_able_to(:index, User) }
    it { should be_able_to(:new, User) }
    it { should be_able_to(:create, technician) }
    it { should be_able_to(:show, technician) }
    it { should be_able_to(:edit, technician) }
    it { should be_able_to(:update, technician) }
    it { should be_able_to(:destroy, technician) }
    it { should_not be_able_to(:destroy, FactoryGirl.create(:service_advisor)), 'different dealership' }
    it { should be_able_to(:login_as, User) }
    it { should be_able_to(:login, FactoryGirl.create(:service_advisor, dealership: user.dealership)) }
    it { should be_able_to(:login, FactoryGirl.create(:technician, dealership: user.dealership)) }
    it { should_not be_able_to(:login, FactoryGirl.create(:admin)) }
    it { should_not be_able_to(:login, FactoryGirl.create(:dealer)) }
    it { should_not be_able_to(:login, FactoryGirl.create(:service_advisor)) }
    it { should_not be_able_to(:login, FactoryGirl.create(:technician)) }

    it { should_not be_able_to(:new, FactoryGirl.create(:vehicle_report_card, user: technician)) }
    it { should_not be_able_to(:create, FactoryGirl.create(:vehicle_report_card, user: technician)) }
    it { should be_able_to(:edit, FactoryGirl.create(:vehicle_report_card, user: technician)) }
    it { should_not be_able_to(:update, FactoryGirl.create(:vehicle_report_card, user: technician)) }
    it { should_not be_able_to(:destroy, FactoryGirl.create(:vehicle_report_card, user: technician)) }
    it { should_not be_able_to(:send_pdf, FactoryGirl.create(:vehicle_report_card, user: technician)) }
    it { should_not be_able_to(:email_pdf, FactoryGirl.create(:vehicle_report_card, user: technician)) }

    it 'should be accessible' do
      vehicle_report_card = FactoryGirl.create(:vehicle_report_card, user: technician)
      expect(VehicleReportCard.accessible_by(Ability.new user).include?(vehicle_report_card)).to be_truthy
    end

    it 'vehicle report card should not be accessible created by other dealership' do
      vehicle_report_card = FactoryGirl.create(:vehicle_report_card, user: create(:technician))
      expect(VehicleReportCard.accessible_by(Ability.new user).include?(vehicle_report_card)).to be_falsey
    end
  end


  describe 'service advisor' do
    subject(:ability) { Ability.new(user) }
    let(:user) { FactoryGirl.create(:service_advisor) }
    let(:technician) { FactoryGirl.create(:technician, dealership: user.dealership) }

    it { should_not be_able_to(:index, FactoryGirl.create(:dealership)) }
    it { should_not be_able_to(:new, FactoryGirl.create(:dealership)) }
    it { should_not be_able_to(:create, FactoryGirl.create(:dealership)) }
    it { should_not be_able_to(:show, FactoryGirl.create(:dealership)) }
    it { should_not be_able_to(:edit, FactoryGirl.create(:dealership)) }
    it { should_not be_able_to(:update, FactoryGirl.create(:dealership)) }
    it { should_not be_able_to(:destroy, FactoryGirl.create(:dealership)) }


    it { should_not be_able_to(:index, User) }
    it { should_not be_able_to(:new, User) }
    it { should_not be_able_to(:create, technician) }
    it { should_not be_able_to(:show, technician) }
    it { should_not be_able_to(:edit, technician) }
    it { should_not be_able_to(:update, technician) }
    it { should_not be_able_to(:destroy, technician) }
    it { should_not be_able_to(:destroy, FactoryGirl.create(:service_advisor)), 'different dealership' }
    it { should_not be_able_to(:login_as, User) }
    it { should_not be_able_to(:login, FactoryGirl.create(:service_advisor, dealership: user.dealership)) }
    it { should_not be_able_to(:login, FactoryGirl.create(:technician, dealership: user.dealership)) }
    it { should_not be_able_to(:login, FactoryGirl.create(:admin)) }
    it { should_not be_able_to(:login, FactoryGirl.create(:dealer)) }
    it { should_not be_able_to(:login, FactoryGirl.create(:service_advisor)) }
    it { should_not be_able_to(:login, FactoryGirl.create(:technician)) }

    it { should_not be_able_to(:new, FactoryGirl.create(:vehicle_report_card, user: technician, service_advisor_id: user.id)) }
    it { should_not be_able_to(:create, FactoryGirl.create(:vehicle_report_card, user: technician, service_advisor_id: user.id)) }
    it { should be_able_to(:edit, FactoryGirl.create(:vehicle_report_card, user: technician, service_advisor_id: user.id)) }
    it { should be_able_to(:update, FactoryGirl.create(:vehicle_report_card, user: technician, service_advisor_id: user.id)) }
    it { should_not be_able_to(:destroy, FactoryGirl.create(:vehicle_report_card, user: technician, service_advisor_id: user.id)) }
    it { should be_able_to(:send_pdf, FactoryGirl.create(:vehicle_report_card, user: technician, service_advisor_id: user.id)) }
    it { should be_able_to(:email_pdf, FactoryGirl.create(:vehicle_report_card, user: technician, service_advisor_id: user.id)) }

    it 'should be accessible' do
      vehicle_report_card = FactoryGirl.create(:vehicle_report_card, user: technician, service_advisor_id: user.id)
      expect(VehicleReportCard.accessible_by(Ability.new user).include?(vehicle_report_card)).to be_truthy
    end

    it 'should not be accessible' do
      vehicle_report_card = FactoryGirl.create(:vehicle_report_card, user: technician, service_advisor_id: -100)
      expect(VehicleReportCard.accessible_by(Ability.new user).include?(vehicle_report_card)).to be_falsey
    end
  end


  describe 'technician' do
    subject(:ability) { Ability.new(user) }
    let(:user) { FactoryGirl.create(:technician) }
    let(:technician) { user}

    it { should_not be_able_to(:index, FactoryGirl.create(:dealership)) }
    it { should_not be_able_to(:new, FactoryGirl.create(:dealership)) }
    it { should_not be_able_to(:create, FactoryGirl.create(:dealership)) }
    it { should_not be_able_to(:show, FactoryGirl.create(:dealership)) }
    it { should_not be_able_to(:edit, FactoryGirl.create(:dealership)) }
    it { should_not be_able_to(:update, FactoryGirl.create(:dealership)) }
    it { should_not be_able_to(:destroy, FactoryGirl.create(:dealership)) }


    it { should_not be_able_to(:index, User) }
    it { should_not be_able_to(:new, User) }
    it { should_not be_able_to(:create, technician) }
    it { should_not be_able_to(:show, technician) }
    it { should_not be_able_to(:edit, technician) }
    it { should_not be_able_to(:update, technician) }
    it { should_not be_able_to(:destroy, technician) }
    it { should_not be_able_to(:destroy, FactoryGirl.create(:service_advisor)), 'different dealership' }
    it { should_not be_able_to(:login_as, User) }
    it { should_not be_able_to(:login, FactoryGirl.create(:service_advisor, dealership: user.dealership)) }
    it { should_not be_able_to(:login, FactoryGirl.create(:technician, dealership: user.dealership)) }
    it { should_not be_able_to(:login, FactoryGirl.create(:admin)) }
    it { should_not be_able_to(:login, FactoryGirl.create(:dealer)) }
    it { should_not be_able_to(:login, FactoryGirl.create(:service_advisor)) }
    it { should_not be_able_to(:login, FactoryGirl.create(:technician)) }

    it { should be_able_to(:index, FactoryGirl.create(:vehicle_report_card, user: user)) }
    it { should be_able_to(:new, FactoryGirl.create(:vehicle_report_card, user: user)) }
    it { should be_able_to(:create, FactoryGirl.create(:vehicle_report_card, user: user)) }
    it { should be_able_to(:show, FactoryGirl.create(:vehicle_report_card, user: user)) }
    it { should be_able_to(:edit, FactoryGirl.create(:vehicle_report_card, user: user)) }
    it { should be_able_to(:update, FactoryGirl.create(:vehicle_report_card, user: user)) }
    it 'should not update already sent_to_customer report' do
      vehicle_report_card = FactoryGirl.create(:vehicle_report_card, user: user)
      vehicle_report_card.review!
      vehicle_report_card.send_to_customer!
      should_not be_able_to(:update, vehicle_report_card)
    end
    it 'should not update already reviewed report' do
      vehicle_report_card = FactoryGirl.create(:vehicle_report_card, user: user)
      vehicle_report_card.review!
      should_not be_able_to(:update, vehicle_report_card)
    end
    it { should be_able_to(:destroy, FactoryGirl.create(:vehicle_report_card, user: user)) }
    it { should_not be_able_to(:send_pdf, FactoryGirl.create(:vehicle_report_card, user: technician)) }
    it { should_not be_able_to(:email_pdf, FactoryGirl.create(:vehicle_report_card, user: technician)) }


    it 'should be accessible' do
      vehicle_report_card = FactoryGirl.create(:vehicle_report_card, user: technician)
      expect(VehicleReportCard.accessible_by(Ability.new user).include?(vehicle_report_card)).to be_truthy
    end

    it 'should not be accessible' do
      vehicle_report_card = FactoryGirl.create(:vehicle_report_card, user: create(:technician))
      expect(VehicleReportCard.accessible_by(Ability.new user).include?(vehicle_report_card)).to be_falsey
    end
  end
end
