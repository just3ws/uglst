class Source < ActiveRecord::Base
  include Twitterable

  extend FriendlyId
  friendly_id :name, use: :slugged

  default_scope { order('created_at ASC') }

  validates :name, presence: true, uniqueness: true, allow_blank: false
end

# == Schema Information
#
# Table name: sources
#
#  id          :uuid             not null, primary key
#  name        :string
#  description :text
#  homepage    :string
#  twitter     :string
#  slug        :string
#  created_at  :datetime
#  updated_at  :datetime
#
