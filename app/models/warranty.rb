class Warranty < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :inventory
end
