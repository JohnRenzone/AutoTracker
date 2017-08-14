class Specification < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :category


end
