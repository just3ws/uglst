class Profile < ActiveRecord::Base
  default_scope -> { order('created_at ASC') }

  belongs_to :user, inverse_of: :profile

  include Twitterable

  def full_name
    "#{first_name} #{last_name}".strip
  end

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

  crypt_keeper :address,
    :formatted_address,
    encryptor:        :postgres_pgp,
    key:              ENV['CRYPT_KEEPER_KEY'],
    pgcrypto_options: 'compress-level=9',
    encoding:         'UTF-8'
end

# == Schema Information
# Schema version: 20140616040112
#
# Table name: profiles
#
#  id                :uuid             not null, primary key
#  user_id           :uuid
#  twitter           :string(255)
#  homepage          :string(255)
#  first_name        :string(255)
#  last_name         :string(255)
#  interests         :string(255)      is an Array
#  bio               :text
#  address           :text
#  formatted_address :text
#  city              :string(255)
#  state_province    :string(255)
#  country           :string(255)
#  latitude          :float            indexed => [longitude]
#  longitude         :float            indexed => [latitude]
#  created_at        :datetime         indexed
#  updated_at        :datetime
#
# Indexes
#
#  index_profiles_on_created_at              (created_at)
#  index_profiles_on_latitude_and_longitude  (latitude,longitude)
#
