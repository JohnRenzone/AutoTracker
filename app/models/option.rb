class Option < ActiveRecord::Base
  acts_as_paranoid


  has_many :inventories_options
  has_many :inventories, through: :inventories_options
end
