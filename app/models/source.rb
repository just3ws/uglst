class Source < ActiveRecord::Base
  include Twitterable

  extend FriendlyId
  friendly_id :name, use: :slugged

  default_scope -> { order('created_at ASC') }

  validates :name, presence: true, uniqueness: true, allow_blank: false
end

# == Schema Information
# Schema version: 20140730061759
#
# Table name: sources
#
#  id          :uuid             not null, primary key
#  name        :string(255)
#  description :text
#  homepage    :string(255)
#  twitter     :string(255)
#  slug        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#
