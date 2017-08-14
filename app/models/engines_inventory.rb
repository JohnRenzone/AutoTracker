class EnginesInventory < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :inventory
  belongs_to :engine
end
