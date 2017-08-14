class Battery < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :vehicle_report_card, :inverse_of => :battery
  validates_presence_of :vehicle_report_card
end
