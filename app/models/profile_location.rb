# frozen_string_literal: true
class ProfileLocation < ActiveRecord::Base
  belongs_to :profile
  belongs_to :location

  validates :profile, presence: true
  validates :location, presence: true
end

# == Schema Information
#
# Table name: profile_locations
#
#  id          :uuid             not null, primary key
#  profile_id  :uuid
#  location_id :uuid
#  label       :string
#  created_at  :datetime
#  updated_at  :datetime
#
