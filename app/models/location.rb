class Location < ActiveRecord::Base
  include Geocodable

  has_many :user_group_locations
  has_many :user_groups, through: :user_group_locations
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
