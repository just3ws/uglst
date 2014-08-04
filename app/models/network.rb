class Network < ActiveRecord::Base
  include Twitterable

  include PublicActivity::Model
  tracked owner: proc { |controller, _model| controller.current_user }

  has_paper_trail

  include PgSearch
  pg_search_scope :search_for,
                  against: %i(name description),
                  using:   %i(tsearch trigram)

  extend FriendlyId
  friendly_id :name, use: :slugged

  mount_uploader :logo, NetworkLogoUploader

  default_scope -> { order('created_at ASC') }

  belongs_to :registered_by, class_name: 'User', foreign_key: 'registered_by_id'

  has_many :network_affiliations
  has_many :user_groups, through: :network_affiliations

  validates :name, presence: true, uniqueness: true, length: { minimum: 8, maximum: 64 }, allow_blank: false
end

# == Schema Information
# Schema version: 20140730061759
#
# Table name: networks
#
#  id               :uuid             not null, primary key
#  registered_by_id :uuid
#  homepage         :string(255)
#  name             :text
#  slug             :string(255)
#  twitter          :string(255)
#  description      :text
#  logo             :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#
