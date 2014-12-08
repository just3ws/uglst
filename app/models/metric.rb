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
