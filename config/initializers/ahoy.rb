Ahoy.geocode = :async

class Ahoy::Store < Ahoy::Stores::ActiveRecordStore
  def report_exception(e)
    Rollbar.report_exception(e)
  end
end
