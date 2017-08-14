require 'rails_helper'

describe Users::RegistrationsController, :type => :controller do

  describe "#after_sign_in_path_for" do

    context "user is admin or dealer" do
      let(:user) { FactoryGirl.create(:dealer, password: 'testpass') }
      before(:each) do
        login_with create(:dealer)
        user.role = 0 || 1
        expect(user).to be_valid
      end
      it "does not include return_to param when return_to is user_root_path" do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        allow(controller).to receive_messages(params: {return_to: user_root_path})
        controller.send(:store_location!)
        controller.send(:build_resource)
        path = controller.send(:after_sign_in_path_for, controller.send(:resource))
        expect(path).to eq(user_root_path)
      end
      it "includes return_to param" do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        allow(controller).to receive_messages(params: {return_to: test_path})
        controller.send(:store_location!)
        controller.send(:build_resource)
        path = controller.send(:after_sign_in_path_for, controller.send(:resource))
        expect(path).to eq(test_path)
      end
    end

    context "user is service advisor" do
      let(:user) { FactoryGirl.create(:dealer, password: 'testpass') }
      before(:each) do
        login_with create(:dealer)
        user.role = 2
        expect(user).to be_valid
      end
      it "does not include return_to param when return_to is user_root_path" do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        allow(controller).to receive_messages(params: {return_to: user_root_path})
        controller.send(:store_location!)
        controller.send(:build_resource)
        path = controller.send(:after_sign_in_path_for, controller.send(:resource))
        expect(path).to eq(user_root_path)
      end
      it "includes return_to param" do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        allow(controller).to receive_messages(params: {return_to: test_path})
        controller.send(:store_location!)
        controller.send(:build_resource)
        path = controller.send(:after_sign_in_path_for, controller.send(:resource))
        expect(path).to eq(test_path)
      end
    end

  end

  context 'when user send invitation' do
    let(:user) { FactoryGirl.create(:dealer,password: 'testpass') }
    let (:invited_user) {
        User.any_instance.stub(:send_welcome_emails).and_return(true)
        FactoryGirl.create(:dealer) }

    describe "#after auth" do
      it "should redirect to inviter" do
        sign_in(user)
        expect(user).to be_valid
        expect(invited_user).to be_valid
        @request.env['devise.mapping'] = Devise.mappings[:user]
        allow(controller).to receive_messages(params: {return_to: test_path})
        controller.send(:store_location!)
        controller.send(:build_resource)
        path = controller.send(:after_sign_in_path_for, controller.send(:resource))
        expect(path).to eq(test_path)
      end
    end
  end

end
