require 'rails_helper'

RSpec.describe "dealerships/new", type: :view do
  before(:each) do
    assign(:dealership, Dealership.new())
  end

  it "renders new dealership form" do
    render

    assert_select "form[action=?][method=?]", dealerships_path, "post" do
    end
  end
end
