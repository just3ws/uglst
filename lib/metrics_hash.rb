#
# encapsulates a Hash that enforces type rules on keys/vals
# and provides special to_s output
#
class MetricsHash < Hash
  KEY_REGEX = /^[a-zA-Z0-9\-_]+$/

  def initialize
    @metrics = {}
  end

  def []=(key, val)
    fail "Key must be a string matching #{KEY_REGEX}" unless KEY_REGEX.match(key)
    fail 'Val must respond to :to_s' unless val.respond_to?(:to_s)

    @metrics[key] = val
  end

  def [](key)
    @metrics[key]
    end

  def clear
    @metrics.clear
  end

end
