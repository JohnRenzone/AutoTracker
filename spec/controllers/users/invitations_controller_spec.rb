require 'rails_helper'

describe Users::InvitationsController, :type => :controller do

  describe "#update_resource when current user is admin" do
    let(:invited_user) { FactoryGirl.create(:dealer, password: 'testpass1') }

    it "when current user is admin then update user" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      patch :update, id: invited_user, User: FactoryGirl.attributes_for(:admin)
      invited_user.reload
      expect(invited_user.role).to eq('dealer')
    end

  end

  describe "#update_resource when current user is dealer" do
    let(:invited_user) { FactoryGirl.create(:service_advisor, password: 'testpass1') }

    it "when current user is dealer then update user" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      patch :update, id: invited_user, User: FactoryGirl.attributes_for(:dealer)
      invited_user.reload
      expect(invited_user.role).to eq('service_advisor')
    end

  end
end