class CreateInventoryWorker
  include Sidekiq::Worker

  def perform(vin)
    Inventory.decode_vin_and_save(vin) if Inventory.find_by_vin(vin).blank?
  end
end