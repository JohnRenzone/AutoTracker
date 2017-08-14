require 'rails_helper'

RSpec.describe InventoriesController, type: :controller do

  context '#create' do
    before(:each) do
      login_as_technician
    end

    context 'valid params' do
      context 'when inventory does not exists' do
        it "does not creates inventory" do

          _double = double('VinDecoder::DataOneSoftware')
          allow(VinDecoder::DataOneSoftware).to receive(:new).and_return(_double)
          allow(_double).to receive(:decode) { _double }
          allow(_double).to receive(:has_errors?) { true }
          allow(_double).to receive(:errors) { {} }
          allow(_double).to receive(:map) { _double }

          xhr :post, :create, inventory: {vin: generate(:vin)}

          expect(response.status).to eql(200)
          expect(Inventory.count).to eq(0)
        end
      end

      context 'when inventory already exists' do
        let(:inventory) { create(:inventory) }

        it "create inventory" do
          xhr :post, :create, inventory: {vin: inventory.vin}

          expect(response.status).to eql(200)
        end
      end
    end
  end
end