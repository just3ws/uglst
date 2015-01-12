class Profile < ActiveRecord::Base
  include Geocodable

  default_scope { order('created_at ASC') }

  crypt_keeper :address,
               :formatted_address,
               encryptor: :postgres_pgp,
               key: ENV['CRYPT_KEEPER_KEY'],
               pgcrypto_options: 'compress-level=9',
               encoding: 'UTF-8'

  has_paper_trail skip: %i(address formatted_address)

  acts_as_taggable_on :interests

  belongs_to :user, inverse_of: :profile

  has_one :profile_twitter_account
  has_one :twitter_account, through: :profile_twitter_account

  def preferred_name_or_username
    if preferred_name.present?
      preferred_name
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
#  homepage          :string(255)
#  first_name        :string(255)
#  last_name         :string(255)
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
#  username          :string(255)
#  preferred_name    :string(255)
#
