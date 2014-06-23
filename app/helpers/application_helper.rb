module ApplicationHelper
  def reminder_to(note)
    Rails.logger.info "[REMINDER TO]: #{note}. (#{caller.first})"
    yield if block_given? unless Rails.env.production?
  end

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
    #{messages}
    </div>
    HTML
    html.html_safe
  end
end
