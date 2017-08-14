class InventoriesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def create
    if inventory_params[:vin].present?
      @inventory = Inventory.find_by_vin(inventory_params[:vin]) || Inventory.decode_vin_and_save(inventory_params[:vin])
    end
  end

  private
  def inventory_params
    params.require(:inventory).permit(:vin)
  end
end