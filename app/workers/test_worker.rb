class TestWorker
  include Sidekiq::Worker

  def perform(id)
    Rails.logger.info id
  end
end