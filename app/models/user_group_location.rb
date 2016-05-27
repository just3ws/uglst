# frozen_string_literal: true
class UserGroupLocation < ActiveRecord::Base
  belongs_to :location
  belongs_to :user_group

  validates :location, presence: true
  validates :user_group, presence: true
end

# == Schema Information
#
# Table name: user_group_locations
#
#  id            :uuid             not null, primary key
#  user_group_id :uuid
#  location_id   :uuid
#  created_at    :datetime
#  updated_at    :datetime
#
