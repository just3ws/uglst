class UserGroup < ActiveRecord::Base
  include Twitterable

  include PublicActivity::Model
  tracked owner: proc { |controller, _model| controller.current_user }

  has_paper_trail

  include PgSearch
  pg_search_scope :search_for,
                  against: %i(name description topics city state_province country),
                  using:   %i(tsearch trigram)

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  mount_uploader :logo, UserGroupLogoUploader

  geocoded_by :address

  default_scope -> { order('created_at ASC') }

  belongs_to :registered_by, class_name: 'User', foreign_key: 'registered_by_id'

  has_many :network_affiliations
  has_many :networks, through: :network_affiliations

  has_one :source_history
  has_one :source, through: :source_history

  has_many :user_group_memberships
  has_many :users, through: :user_group_memberships

  validates :city, presence: true
  validates :country, presence: true
  validates :description, presence: true, length: { minimum: 8, maximum: 2048 }, allow_blank: false
  validates :homepage, presence: true
  validates :name, presence: true, uniqueness: true, length: { minimum: 8, maximum: 64 }, allow_blank: false

  after_commit :send_tweet!
  after_validation :geocode

  def slug_candidates
    [
      :name,
      [:name, :city],
      [:name, :city, :state_province],
      [:name, :city, :state_province, :country]
    ]
  end

  def address
    [city, state_province, country].join(', ')
  end

  def send_tweet!
    UserGroupTweeterJob.new.async.perform(id)
  end
end

# == Schema Information
# Schema version: 20140730061759
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
#  created_at        :datetime
#  updated_at        :datetime
#
