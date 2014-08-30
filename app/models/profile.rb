class Profile < ActiveRecord::Base
  include Twitterable

  default_scope -> { order('created_at ASC') }

  crypt_keeper :address,
               :formatted_address,
               encryptor:        :postgres_pgp,
               key:              ENV['CRYPT_KEEPER_KEY'],
               pgcrypto_options: 'compress-level=9',
               encoding:         'UTF-8'

  has_paper_trail skip: %i(address formatted_address)

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

  belongs_to :user, inverse_of: :profile

  after_validation :geocode

  def full_name
    "#{first_name} #{last_name}".strip
  end

  def full_name_or_username
    if full_name.present?
      full_name
    else
      user.username
    end
  end
end

# == Schema Information
# Schema version: 20140830050619
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
#  latitude          :float
#  longitude         :float
#  created_at        :datetime
#  updated_at        :datetime
#
