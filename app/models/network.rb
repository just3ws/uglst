class Network < ActiveRecord::Base
  default_scope -> { order('created_at ASC') }

  include PublicActivity::Model
  tracked owner: proc { |controller, _model| controller.current_user }

  has_paper_trail

  include Twitterable

  mount_uploader :logo, NetworkLogoUploader

  include PgSearch
  # https://github.com/Casecommons/pg_search
  pg_search_scope :search_for,
                  against: %i(name description),
                  using:   %i(tsearch trigram)

  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :homepage, presence: true
  validates :name, presence: true, uniqueness: true, length: { minimum: 8, maximum: 64 }, allow_blank: false

  belongs_to :registered_by, class_name: 'User', foreign_key: 'registered_by_id'

  has_many :user_groups
  has_many :user_groups, through: :network_affiliations
end

# == Schema Information
# Schema version: 20140628174646
#
# Table name: networks
#
#  id               :uuid             not null, primary key
#  registered_by_id :uuid
#  homepage         :string(255)
#  name             :text             indexed
#  slug             :string(255)
#  twitter          :string(255)
#  description      :text
#  logo             :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#
# Indexes
#
#  index_networks_on_name  (name)
#
