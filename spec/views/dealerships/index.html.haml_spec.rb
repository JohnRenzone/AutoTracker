require 'rails_helper'

RSpec.describe "dealerships/index", type: :view do
  before(:each) do
    create(:dealership)
    assign(:dealerships, Dealership.order('dealerships.created_at desc').page(params[:page]))
  end

  it "renders a list of dealerships" do
    render
  end
end
