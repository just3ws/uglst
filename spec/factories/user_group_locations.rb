# frozen_string_literal: true
FactoryGirl.define do
  factory :user_group_location do
    user_group_id ''
    location_id ''
  end
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
