module UtilHelper
  def autotracker_log message
    if ENV['VERBOSE']
      Rails.logger.info "#-----> #{message.to_s}"
      puts "#-----> #{message.to_s}"
    end
  end
end