require "rails_helper"

RSpec.describe "vehicle_report_cards/create" do

  context 'create.js' do
    context "success" do
      before(:each) do
        assign(:vehicle_report_card, create(:vehicle_report_card))
      end

      # it "displays data" do
      #   render
      #   expect(rendered).to include "$('form[name='report_card']').attr('action', '/reports/<%= @vehicle_report_card.id %>');"
      #   expect(rendered).to include "$('form[name='report_card']').attr('id','edit_vehicle_report_card_<%= @vehicle_report_card.id %>');"
      # end
    end

  end
end