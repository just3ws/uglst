# frozen_string_literal: true
class Profile < ActiveRecord::Base
  include Geocodable

  default_scope { order('created_at ASC') }

  has_paper_trail skip: %i(address formatted_address)

  acts_as_taggable_on :interests

  belongs_to :user, inverse_of: :profile

  has_one :profile_twitter_account
  has_one :twitter_account, through: :profile_twitter_account

  has_one :profile_location
  has_one :location, through: :profile_location

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
#  homepage          :string
#  first_name        :string
#  last_name         :string
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
#  preferred_name    :string
#
