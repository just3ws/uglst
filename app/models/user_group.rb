class UserGroup < ActiveRecord::Base
  default_scope -> { order('created_at ASC') }
  has_paper_trail

  include Twitterable

  mount_uploader :logo, UserGroupLogoUploader

  include PgSearch
  # https://github.com/Casecommons/pg_search
  pg_search_scope :search_for,
                  against: %i(
                    name
                    topics
                    city
                    state_province
                    country
                  ),
                  using:   %i(tsearch trigram)

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
    [city, state_province, country].join(', ')
  end
end

# == Schema Information
# Schema version: 20140616040112
#
# Table name: user_groups
#
#  id                :uuid             not null, primary key
#  registered_by_id  :uuid
#  homepage          :string(255)
#  name              :string(255)
#  slug              :string(255)
#  twitter           :string(255)
#  description       :text
#  topics            :text             is an Array
#  address           :text
#  formatted_address :text
#  city              :string(255)
#  state_province    :string(255)
#  country           :string(255)
#  latitude          :string(255)
#  longitude         :string(255)
#  logo              :string(255)
#  created_at        :datetime         indexed
#  updated_at        :datetime
#
# Indexes
#
#  index_user_groups_on_created_at  (created_at)
#
