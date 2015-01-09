module Twitterable
  extend ActiveSupport::Concern

  def format_twitter(params_with_twitter)
    return true unless params_with_twitter.key?(:twitter)

    if params_with_twitter[:twitter].present?
      screen_name = params_with_twitter[:twitter].to_s.downcase.strip

      begin

        params_with_twitter[:twitter] = Uglst::Values::Twitter.new(screen_name: screen_name)

      rescue Twitter::Error::NotFound => ex
        # model.errors.add(:twitter, "screen name '#{screen_name}' was not found.")
        flash[:alert] += ["Twitter screen name '#{screen_name}' was not found."]

        params_with_twitter[:twitter] = nil

        Rails.logger.error(ex.message + "\n  " + ex.backtrace.join("\n  "))
      end
    else
      # If the key exists but the value is not present then set the value to nil (as it is probably an empty string).
      params_with_twitter[:twitter] = nil
    end
  end
end
