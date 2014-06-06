class UserGroup < ActiveRecord::Base
  include Twitterable

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  validates :name, presence: true, uniqueness: true
  validates :city, presence: true
  validates :state_province, presence: true
  validates :country, presence: true
  validates :homepage, presence: true

  belongs_to :registered_by, class_name: 'User', foreign_key: 'registered_by_id'

  def slug_candidates
    [
      :name,
      [:name, :city],
      [:name, :city, :country]
    ]
  end

  geocoded_by :full_street_address
  after_validation :geocode, if: ->(obj) { self.class.needs_geocoding?(obj) }
  def full_street_address
    [ city, state_province, country ].join(', ')
  end

  def self.needs_geocoding?(obj)
    %w[
    city
    state_province
    country
    ].any? { |attr| obj.send(attr.to_sym).present? and obj.send("#{attr}_changed?".to_sym) }
  end
end

# == Schema Information
# Schema version: 20140530064405
#
# Table name: user_groups
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  city             :string(255)
#  state_province   :string(255)
#  country          :string(255)
#  latitude         :string(255)
#  longitude        :string(255)
#  slug             :string(255)
#  homepage         :string(255)
#  twitter          :string(255)
#  description      :string(255)
#  registered_by_id :integer          indexed
#  topics           :text
#  created_at       :datetime
#  updated_at       :datetime
#
# Indexes
#
#  index_user_groups_on_registered_by_id  (registered_by_id)
#
