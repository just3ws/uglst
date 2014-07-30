class Source < ActiveRecord::Base
  include Twitterable

  extend FriendlyId
  friendly_id :name, use: :slugged

  default_scope -> { order('created_at ASC') }

  validates :name, presence: true, uniqueness: true, allow_blank: false
end
