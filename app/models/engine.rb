class Engine < ActiveRecord::Base
  acts_as_paranoid

  validates :data_one_engine_id, presence: true

  has_many :engines_inventories
  has_many :inventories, through: :engines_inventories
end
