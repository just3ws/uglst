class User < ActiveRecord::Base
  crypt_keeper :parental_status, :birthday, :ethnicity, :gender, :race,
    :relationship_status, :religious_affiliation, :sexual_orientation,
    encryptor: :aes_new, key: ENV['CRYPT_KEEPER_KEY'], salt: ENV['CRYPT_KEEPER_SALT'], encoding: 'UTF-8'

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  include Twitterable

  extend FriendlyId
  friendly_id :username, use: :slugged

  validates :username, presence: true, uniqueness: true
  validates_date :birthday,

  has_many :user_groups_registered, foreign_key: 'registered_by_id', class_name: 'UserGroup'

  def full_name
    "#{first_name} #{last_name}".strip
  end

  geocoded_by :full_street_address   # can also be an IP address
  after_validation :geocode, if: ->(obj) { self.class.needs_geocoding?(obj) }
  def full_street_address
    [
      street,
      city,
      state_province,
      postal_code,
      country
    ].reject { |v| v.to_s.strip.empty? }.join(', ')
  end

  def self.needs_geocoding?(obj)
    %w[
      street
      city
      state_province
      postal_code
      country
    ].any? { |attr| obj.send(attr.to_sym).present? and obj.send("#{attr}_changed?".to_sym) }
  end
end

# == Schema Information
# Schema version: 20140530064405
#
# Table name: users
#
#  id                     :uuid             not null, primary key
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
#  street                 :string(255)
#  city                   :string(255)
#  state_province         :string(255)
#  country                :string(255)
#  postal_code            :string(255)
#  birthday               :date
#  gender                 :string(255)      default([]), is an Array
#  ethnic_groups          :string(255)      default([]), is an Array
#  race                   :string(255)      default([]), is an Array
#  sexual_orientation     :string(255)      default([]), is an Array
#  email_opt_in           :boolean          default(FALSE)
#  send_stickers          :boolean
#  stickers_sent_on       :date
#  interests              :text
#  bio                    :text
#  latitude               :float            indexed => [longitude]
#  longitude              :float            indexed => [latitude]
#  admin                  :boolean          default(FALSE)
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
