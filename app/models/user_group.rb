class UserGroup < ActiveRecord::Base
  include Twitterable

  include PgSearch
  # https://github.com/Casecommons/pg_search
  pg_search_scope :search_for,
    against: %i[
      name
      topics
      city
      state_province
      country
    ],
    using: %i[tsearch trigram]

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
      [:name, :city, :state_province],
      [:name, :city, :state_province, :country]
    ]
  end



  geocoded_by :address
  after_validation :geocode
  def address
    [ city, state_province, country ].join(', ')
  end
end

# == Schema Information
# Schema version: 20140530064405
#
# Table name: user_groups
#
#  id               :uuid             not null, primary key
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
#  registered_by_id :uuid             indexed
#  topics           :string(255)      is an Array
#  created_at       :datetime
#  updated_at       :datetime
#
# Indexes
#
#  index_user_groups_on_registered_by_id  (registered_by_id)
#
