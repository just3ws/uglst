class Metric < ActiveRecord::Base
  # create a splunk-friendly representation of the hash:
  # tuples joined with equals and separated by spaces
  def to_splunk
    @metrics.sort.map do |key, val|
      klass = val.class
      if klass == Float
        # ruby likes to output small floats in scientific notation, but we don't
        val = sprintf('%0.6f', val)
      elsif klass == String
        # escape quotes
        val.gsub!('"', '\"')
        # quote strings that have spaces
        val = "\"#{val}\"" if val.index(' ') || val.empty?
      elsif klass == NilClass
        val = '""'
      end
      "#{key}=#{val}"
    end.join(' ')
  end
end

# == Schema Information
#
# Table name: metrics
#
#  id                   :uuid             not null, primary key
#  session_id           :string
#  request_action       :string
#  request_controller   :string
#  request_ip           :string
#  request_method       :string
#  request_referrer     :string
#  request_requestor_ip :string
#  request_url          :string
#  request_user_agent   :string
#  request_xff          :string
#  user_id              :uuid
#  request_params       :json
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
