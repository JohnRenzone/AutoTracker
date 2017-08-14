require 'rails_helper'

class DummyController < DeviseController
  include DeviseReturnToConcern
  attr_accessor :params, :session, :resource_name
  def initialize
    @params = {}.with_indifferent_access
    @session = {}.with_indifferent_access
    @resource_name = 'user'
  end
  def is_navigational_format?; true; end
end

describe DeviseReturnToConcern, :type => :controller do
  let(:controller) { DummyController.new }
  let(:user) { FactoryGirl.create(:dealer, password: 'testpass') }

  describe "store_location!" do
    it "sets session when return_to param is present" do
      path = '/some/test/path'
      controller.params = { return_to: path }
      controller.store_location!
      expect(controller.session[:"#{controller.resource_name}_return_to"]).to eq(path)
      expect(controller.session[:"#{controller.resource_name}_return_to_timestamp"]).to be >= Time.now.utc.to_i
      expect(controller.stored_location_for(controller.resource_name)).to eq(path)
    end
    it "does not change session when return_to is missing" do
      controller.store_location!
      expect(controller.session[:"#{controller.resource_name}_return_to"]).to be_nil
      expect(controller.session[:"#{controller.resource_name}_return_to_timestamp"]).to be_nil
      expect(controller.stored_location_for(controller.resource_name)).to be_nil
    end
  end
end
