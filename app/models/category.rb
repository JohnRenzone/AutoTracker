class Category < ActiveRecord::Base
  acts_as_paranoid

  has_many :specifications
  has_many :equipments
  has_many :options
end
