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
#  session_id           :string(255)
#  request_action       :string(255)
#  request_controller   :string(255)
#  request_ip           :string(255)
#  request_method       :string(255)
#  request_referrer     :string(255)
#  request_requestor_ip :string(255)
#  request_url          :string(255)
#  request_user_agent   :string(255)
#  request_xff          :string(255)
#  user_id              :uuid
#  request_params       :json
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
