class Profile < ActiveRecord::Base
  include Twitterable

  default_scope { order('created_at ASC') }

  crypt_keeper :address,
               :formatted_address,
               encryptor: :postgres_pgp,
               key: ENV['CRYPT_KEEPER_KEY'],
               pgcrypto_options: 'compress-level=9',
               encoding: 'UTF-8'

  has_paper_trail skip: %i(address formatted_address)

  acts_as_taggable_on :interests

  geocoded_by :address do |obj, results|
    if geo = results.first
      obj.formatted_address = geo.formatted_address
      obj.city = geo.city
      obj.state_province = geo.state
      obj.country = geo.country_code
      obj.latitude = geo.latitude
      obj.longitude = geo.longitude
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
#
# Table name: profiles
#
#  id                :uuid             not null, primary key
#  user_id           :uuid
#  twitter           :string
#  homepage          :string
#  first_name        :string
#  last_name         :string
#  interests         :string           is an Array
#  bio               :text
#  address           :text
#  formatted_address :text
#  city              :string
#  state_province    :string
#  country           :string
#  latitude          :float
#  longitude         :float
#  created_at        :datetime
#  updated_at        :datetime
#  username          :string
#
