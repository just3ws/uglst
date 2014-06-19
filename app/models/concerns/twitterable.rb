module Twitterable
  extend ActiveSupport::Concern

  included do
    before_validation :clean_twitter_name
  end

  def clean_twitter_name
    update_attribute(:twitter, Twitterable.parse(twitter))
  end

  def self.parse(twitter_name)
    # Nothing, exit
    return unless twitter_name.present?

    twitter = twitter_name.downcase

    # They gave us the @name
    if twitter =~ /^@/
      twitter.gsub(/^@/, '')
    elsif twitter =~ URI.regexp
      # Maybe they gave us a url
      ids = IdsPlease.new(twitter)
      ids.parse
      parsed = ids.parsed[:twitter].first

      if parsed
        parsed
      else
        twitter
      end
    else
      twitter
    end
  end
end
