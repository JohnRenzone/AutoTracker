require "rails_helper"

RSpec.describe DealershipsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/dealerships").to route_to("dealerships#index")
    end

    it "routes to #new" do
      expect(:get => "/dealerships/new").to route_to("dealerships#new")
    end

    it "routes to #edit" do
      expect(:get => "/dealerships/1/edit").to route_to("dealerships#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/dealerships").to route_to("dealerships#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/dealerships/1").to route_to("dealerships#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/dealerships/1").to route_to("dealerships#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/dealerships/1").to route_to("dealerships#destroy", :id => "1")
    end

  end
end
