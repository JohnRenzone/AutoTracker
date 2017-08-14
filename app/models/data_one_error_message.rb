class DataOneErrorMessage < ActiveRecord::Base
  acts_as_paranoid

  # Refer DataOne VinDecoder user guide for expected error messages and code.

  validates :type, :code, :message, presence: true
end
