module Twitterable
  extend ActiveSupport::Concern

  included do
    composed_of :twitter, class_name: 'Uglst::Values::Twitter', mapping: %w(twitter user_id), allow_nil: true
  end
end
