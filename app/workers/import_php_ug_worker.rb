class ImportPhpUgWorker
  include Sidekiq::Worker

  def perform
    data = extract
  end

  def extract
    l
  end
end
