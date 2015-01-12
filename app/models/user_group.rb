class UserGroup < ActiveRecord::Base
  include Geocodable

  include PublicActivity::Model
  tracked owner: proc { |c, _| c && c.current_user ? c.current_user : nil }

  has_paper_trail

  include PgSearch
  pg_search_scope :search_for,
                  against: %i(name description city state_province country),
                  using: %i(tsearch trigram)

  extend FriendlyId
  friendly_id :slug_candidates, use: %i(slugged)

  mount_uploader :logo, UserGroupLogoUploader

  acts_as_taggable_on :topics

  default_scope { order('created_at ASC') }

  belongs_to :registered_by, class_name: 'User', foreign_key: 'registered_by_id'

  has_many :network_affiliations
  has_many :networks, through: :network_affiliations

  has_one :source_history
  has_one :source, through: :source_history

  has_many :user_group_memberships
  has_many :users, through: :user_group_memberships

  validates :name,        presence: true, length: { minimum: 2, maximum: 64 },   allow_blank: false, uniqueness: true
  validates :description, presence: nil,  length: { minimum: 8, maximum: 2048 }, allow_blank: false
  validates :shortname,   presence: nil,  length: { minimum: 1, maximum: 15 },   allow_blank: true,  uniqueness: true

  has_one :user_group_twitter_account
  has_one :twitter_account, through: :user_group_twitter_account

  def slug_candidates
    prefix = if shortname.present?
               :shortname
             else
               :name
             end
    [
      prefix,
      [prefix, :city],
      [prefix, :city, :state_province],
      [prefix, :city, :state_province, :country]
    ]
  end
end

# == Schema Information
#
# Table name: user_groups
#
#  id                :uuid             not null, primary key
#  registered_by_id  :uuid
#  homepage          :string(255)
#  name              :string(255)
#  slug              :string(255)
#  description       :text
#  address           :text
#  formatted_address :text
#  city              :string(255)
#  state_province    :string(255)
#  country           :string(255)
#  latitude          :string(255)
#  longitude         :string(255)
#  logo              :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  shortname         :string(255)
#  meetup            :string(255)
#  github            :string(255)
#  facebook          :string(255)
#
