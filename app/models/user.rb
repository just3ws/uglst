class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :send_welcome_email

  include Twitterable

  extend FriendlyId
  friendly_id :username, use: :slugged

  validates :username, presence: true, uniqueness: true

  has_many :user_groups_registered, foreign_key: 'registered_by_id', class_name: 'UserGroup'

  has_one :personal, dependent: :destroy
  accepts_nested_attributes_for :personal, allow_destroy: true

  def full_name
    "#{first_name} #{last_name}".strip
  end

  validates_presence_of :email

  geocoded_by :address do |obj, results|
    if geo = results.first
      obj.formatted_address = geo.formatted_address
      obj.city              = geo.city
      obj.state_province    = geo.state
      obj.country           = geo.country_code
      obj.latitude          = geo.latitude
      obj.longitude         = geo.longitude
    end
  end
  after_validation :geocode

  def personal
    super || build_personal
  end

  def send_welcome_email
    WelcomeEmailJob.new.async.perform(id)
  end
end

# == Schema Information
# Schema version: 20140609184344
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  admin                  :boolean          default(FALSE)
#  email                  :string(255)      default(""), not null, indexed
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)      indexed
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  username               :string(255)      indexed
#  slug                   :string(255)      indexed
#  twitter                :string(255)
#  homepage               :string(255)
#  first_name             :string(255)
#  last_name              :string(255)
#  email_opt_in           :boolean          default(FALSE)
#  send_stickers          :boolean
#  stickers_sent_on       :date
#  interests              :string(255)      is an Array
#  bio                    :text
#  address                :text
#  formatted_address      :text
#  city                   :string(255)
#  state_province         :string(255)
#  country                :string(255)
#  latitude               :float            indexed => [longitude]
#  longitude              :float            indexed => [latitude]
#  created_at             :datetime
#  updated_at             :datetime
#
# Indexes
#
#  index_users_on_email                   (email) UNIQUE
#  index_users_on_latitude_and_longitude  (latitude,longitude)
#  index_users_on_reset_password_token    (reset_password_token) UNIQUE
#  index_users_on_slug                    (slug) UNIQUE
#  index_users_on_username                (username) UNIQUE
#
