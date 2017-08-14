require 'rails_helper'

RSpec.describe VehicleReportCardsController, type: :controller do

  let(:user) { FactoryGirl.create(:dealer, password: 'testpass') }
  let(:vehicle_report_card) { FactoryGirl.create(:vehicle_report_card) }

  describe "GET index" do
    it "renders :index template" do
      login_with create(:technician)
      get :index, order: {vehicle_identification_number: :desc}
      expect(response).to render_template(:index)
    end

    it "renders :index template with user specified" do
      @user = create(:technician)
      login_with @user

      FactoryGirl.create(:vehicle_report_card, user: @user)
      get :index, order: {vehicle_identification_number: :desc}, user: @user.first_name
      expect(response).to render_template(:index)
      expect(assigns(:vehicle_report_cards).count).to eql(1)
    end
  end

  describe "GET new" do
    it "renders :new template" do
      login_with create(:technician)
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST create" do

    context "valid data" do
      context "process request as HTML" do
        it "should create new report card in database" do
          login_with create(:technician)
          expect {
            post :create, vehicle_report_card: FactoryGirl.attributes_for(:vehicle_report_card)
          }.to change(VehicleReportCard, :count).by(1)
        end
      end

      context "process request as JS" do
        it "should create new report card in database" do
          login_with create(:technician)
          xhr :post, :create, vehicle_report_card: FactoryGirl.attributes_for(:vehicle_report_card)

          expect(response).to render_template(:create)
        end
      end

    end

    context "invalid data" do
      context "process request as HTML" do
        it "renders :new template" do
          login_with create(:technician)
          post :create, vehicle_report_card: FactoryGirl.attributes_for(:vehicle_report_card, vehicle_identification_number: ''), format: :html
          expect(response).to render_template(:new)
        end
      end

      context "process request as JS" do
        it "renders :new template" do
          login_with create(:technician)
          post :create, vehicle_report_card: FactoryGirl.attributes_for(:vehicle_report_card, vehicle_identification_number: '')
          xhr :get, :new
          expect(response).to render_template(:new)
        end
      end

      it "doesn't create report card in database" do
        expect {
          post :create, vehicle_report_card: FactoryGirl.attributes_for(:vehicle_report_card, vehicle_identification_number: '')
        }.not_to change(VehicleReportCard, :count)
      end
    end
  end

  describe "GET edit" do
    let(:dealership) { create(:dealership) }
    let(:technician) { create(:technician, dealership: dealership) }
    let(:service_advisor) { create(:service_advisor, dealership: dealership) }
    let (:vehicle_report_card) { FactoryGirl.create(:vehicle_report_card, user: technician, service_advisor_id: service_advisor.id) }
    let (:admin) { FactoryGirl.create(:admin) }

    context "technician" do
      it "renders :edit template" do
        login_with technician
        get :edit, id: vehicle_report_card

        expect(vehicle_report_card.reviewed?).to be_falsey
        assert_template :edit
      end

      it "assigns the requested report card to template" do
        login_with technician
        get :edit, id: vehicle_report_card

        expect(vehicle_report_card.reviewed?).to be_falsey
        assert_template :edit
      end
    end

    context "service advisor" do
      it "renders :edit template" do
        login_with service_advisor
        get :edit, id: vehicle_report_card

        assert_template :edit
        
        vehicle_report_card.reload
        expect(vehicle_report_card.reviewed?).to be_truthy
      end

      it "should not change the state again when he visits for second time" do
        login_with service_advisor
        vehicle_report_card.review!

        get :edit, id: vehicle_report_card

        assert_template :edit
        expect(vehicle_report_card.reviewed?).to be_truthy
      end
    end

    # context "when fluid level is not initialized" do
    #   let (:vehicle_report_card) {
    #     VehicleReportCard.any_instance.stub(:decode_vin_and_save_in_inventory).and_return(true)
    #     FactoryGirl.create(:vehicle_report_card) }
    #
    #   it "renders :edit template with fluid level" do
    #     login_with create(:dealer)
    #     vehicle_report_card.fluid_level = nil
    #     # fluid_level = FactoryGirl.create(:fluid_level)
    #     expect(vehicle_report_card.fluid_level).to be_empty
    #     get :edit, id: vehicle_report_card
    #     expect(response).to render_template(:edit)
    #   end
    # end

  end

  describe "PUT update" do
    context "valid data" do
      let (:technician) { FactoryGirl.create(:technician) }
      let (:valid_data) { FactoryGirl.attributes_for(:vehicle_report_card, user: technician) }
      let (:vehicle_report_card) { FactoryGirl.create(:vehicle_report_card, user_id: technician.id) }

      context "process request as HTML" do
        it "updates report card in database" do
          login_with technician
          put :update, id: vehicle_report_card.id, vehicle_report_card: valid_data
          vehicle_report_card.reload
          expect(vehicle_report_card.vehicle_identification_number).to eq(valid_data[:vehicle_identification_number])
        end
      end

      context "process request as JS" do
        it "updates report card in database" do
          login_with technician
          xhr :put, :update, id: vehicle_report_card.id, vehicle_report_card: valid_data
          vehicle_report_card.reload
          expect(vehicle_report_card.vehicle_identification_number).to eq(valid_data[:vehicle_identification_number])
        end
      end
    end

    context "invalid data" do
      let (:invalid_data) { FactoryGirl.attributes_for(:vehicle_report_card, vehicle_identification_number: '') }
      let (:technician) { FactoryGirl.create(:technician) }
      let (:vehicle_report_card) { FactoryGirl.create(:vehicle_report_card, user_id: technician.id) }

      context "process request as HTML" do
        it "renders :edit template" do
          login_with technician
          put :update, id: vehicle_report_card, vehicle_report_card: invalid_data, format: :html
          expect(response).to render_template(:edit)
        end
      end

      context "process request as JS" do
        it "renders :edit template" do
          login_with technician
          put :update, id: vehicle_report_card, vehicle_report_card: invalid_data
          xhr :get, :edit, id: vehicle_report_card
          expect(response).to render_template(:edit)
        end
      end

      it "doesn't updates report card in database" do
        put :update, id: vehicle_report_card, vehicle_report_card: invalid_data
        vehicle_report_card.reload
      end
    end
  end

end