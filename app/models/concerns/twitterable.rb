module Twitterable
  extend ActiveSupport::Concern

  included do
    before_validation :parse_twitter_name
  end

  def parse_twitter_name
    # Nothing, exit
    return if twitter.to_s.strip.empty?

    # They gave us the @name
    if twitter =~ /^@/
      update_attribute(:twitter, twitter.gsub(/^@/, ''))
    elsif twitter =~ URI::regexp
      # Maybe they gave us a url
      ids = IdsPlease.new(twitter)
      ids.parse
      parsed = ids.parsed[:twitter].first

      update_attribute(:twitter, parsed) if parsed
    end
  end
end
