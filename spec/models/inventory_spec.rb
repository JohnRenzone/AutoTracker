require 'rails_helper'

RSpec.describe Inventory, type: :model do

  it { should accept_nested_attributes_for(:pricing).update_only(true) }
  it { should accept_nested_attributes_for(:safety_equipment).allow_destroy(true) }
  it { should accept_nested_attributes_for(:warranties).allow_destroy(true) }
  it { should accept_nested_attributes_for(:epa_mpg_records).allow_destroy(true) }
  it { should accept_nested_attributes_for(:epa_green_score_records).allow_destroy(true) }
  it { should accept_nested_attributes_for(:interior_colors).allow_destroy(true) }
  it { should accept_nested_attributes_for(:exterior_colors).allow_destroy(true) }
  it { should accept_nested_attributes_for(:roof_colors).allow_destroy(true) }
  it { should accept_nested_attributes_for(:transmissions).allow_destroy(true) }

  context 'save with nested attributes' do
    let(:data_one_xml_string) do
      File.read("#{Rails.root}/spec/fixtures/dataone/sample-out.xml")
    end

    context 'should save' do
      it do
        response = double("response")

        Net::HTTP.any_instance.stub(:post).and_return(response)

        allow(response).to receive(:body).and_return(data_one_xml_string)

        vin_decoder = VinDecoder::DataOneSoftware.new
        vin_decoder.decode('VIN')


        Inventory.create(vin_decoder.inventory_attributes.merge(vin: '1G1LV11W3JE587749'))

        expect(Inventory.count).to be 1
        expect(Engine.count).to be 1
        expect(Pricing.count).to be 1
        expect(SafetyEquipment.count).to be 1
        expect(Transmission.count).to be 1
        expect(ExteriorColor.count).to be 9
        expect(InteriorColor.count).to be 5
        expect(RoofColor.count).to be 0
        expect(EpaMpgRecord.count).to be 1
        expect(EpaGreenScoreRecord.count).to be 1
        expect(Warranty.count).to be 4
      end
    end
  end
end
