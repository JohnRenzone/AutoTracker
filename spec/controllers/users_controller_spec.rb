require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  #TODO Remove it after confirming with JHON
  # context '#new_technician' do
  #   before(:each) do
  #     dealer = create(:dealer)
  #     login_with create(:service_advisor, dealership: dealer.dealership)
  #   end
  #
  #   it "should render new_technician" do
  #     get :new_technician
  #     expect(response).to render_template(:new_technician)
  #   end
  # end
  #
  # context '#create_technician' do
  #   before(:each) do
  #     dealer = create(:dealer)
  #     login_with create(:service_advisor, dealership: dealer.dealership)
  #   end
  #
  #   context 'valid params' do
  #     it "should redirect" do
  #       post :create_technician, user: {username: generate(:username), password: 'password', dealership_id: create(:dealership).id, role: 'technician'}
  #       expect(response).to redirect_to(technicians_users_path)
  #     end
  #   end
  #
  #   context 'invalid params' do
  #     it "should render new_technician" do
  #       technician = create(:technician)
  #       post :create_technician, user: {username: technician.username, password: 'password'}
  #       expect(response).to render_template(:new_technician)
  #     end
  #   end
  # end
  #
  # context '#technicians' do
  #   before(:each) do
  #     dealer = create(:dealer)
  #     login_with create(:service_advisor, dealership: dealer.dealership)
  #   end
  #
  #   it "should render technicians" do
  #     get :technicians
  #     expect(response).to render_template(:technicians)
  #   end
  # end
  #
  # context '#service_advisors' do
  #   before(:each) do
  #     dealer = create(:dealer)
  #     login_with create(:service_advisor, dealership: dealer.dealership)
  #   end
  #
  #   it "should render service_advisors" do
  #     get :service_advisors
  #     expect(response).to render_template(:service_advisors)
  #   end
  # end
end