class UserGroup < ActiveRecord::Base
  include Twitterable

  include PublicActivity::Model
  tracked owner: proc { |_controller, _model| if _controller && _controller.current_user then _controller.current_user else nil end }

  has_paper_trail

  include PgSearch
  pg_search_scope :search_for,
                  against: %i(name description topics city state_province country),
                  using: %i(tsearch trigram)

  extend FriendlyId
  friendly_id :slug_candidates, use: %i(slugged)

  mount_uploader :logo, UserGroupLogoUploader

  geocoded_by :address

  default_scope { order('created_at ASC') }

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
  validates :name, presence: true, length: { minimum: 2, maximum: 64 }, allow_blank: false, uniqueness: true
  validates :shortname, presence: nil, length: { minimum: 1, maximum: 15 }, allow_blank: true, uniqueness: true

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

  def address
    addr_parts = [city, state_province, country].compact
    return nil if addr_parts.empty?
    addr_str = addr_parts.join(', ').sub(/, ,/, ',').sub(/, $/, '').sub(/ ,/, ',')
    if addr_str.blank?
      nil
    else
      addr_str
    end
  end
end

# == Schema Information
#
# Table name: user_groups
#
#  id                :uuid             not null, primary key
#  registered_by_id  :uuid
#  homepage          :string
#  name              :string
#  slug              :string
#  twitter           :string
#  description       :text
#  topics            :text             is an Array
#  address           :text
#  formatted_address :text
#  city              :string
#  state_province    :string
#  country           :string
#  latitude          :string
#  longitude         :string
#  logo              :string
#  created_at        :datetime
#  updated_at        :datetime
#  shortname         :string
#  meetup            :string
#  github            :string
#  facebook          :string
#
