module ApplicationHelper
  def reminder_to(note)
    Rails.logger.info "[REMINDER TO]: #{note}. (#{caller.first})"
    yield if block_given? unless Rails.env.production?
  end
end
