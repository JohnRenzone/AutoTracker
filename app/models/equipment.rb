class Equipment < ActiveRecord::Base
  acts_as_paranoid


  has_many :equipments_inventories
  has_many :inventories, through: :equipments_inventories
end
