class Transmission < ActiveRecord::Base
  acts_as_paranoid

  validates :data_one_transmission_id, presence: true

  has_many :inventories_transmissions
  has_many :inventories, through: :inventories_transmissions
end