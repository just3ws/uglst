class Location < ActiveRecord::Base
  include Geocodable

  has_one :user_group_location
  has_one :user_groups, through: :user_group_location

  has_one :profile_location
  has_one :profile, through: :profile_location
end

# == Schema Information
#
# Table name: locations
#
#  id                :uuid             not null, primary key
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
