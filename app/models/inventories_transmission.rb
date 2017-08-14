class InventoriesTransmission < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :inventory
  belongs_to :transmission
end
