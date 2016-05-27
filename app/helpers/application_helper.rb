# frozen_string_literal: true

require 'string_tools'

module ApplicationHelper
  def display_base_errors(resource)
    return '' if resource.errors.empty? || resource.errors[:base].empty?
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
    #{messages}
    </div>
    HTML
    html.html_safe
  end

  def handle_array_or_csv(val)
    return nil if val.nil?

    if val.is_a?(Array)
      val.join(', ')
    elsif val.is_a?(String)
      StringTools.parse_csv_string_to_array(val)
    else
      raise "Can't handle what I can't recognize #{val.class.name} is not an Array or String"
    end
  end
end
