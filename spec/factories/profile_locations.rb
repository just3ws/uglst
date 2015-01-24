FactoryGirl.define do
  factory :profile_location do
    profile_id ''
    location_id ''
  end
end

# == Schema Information
#
# Table name: profile_locations
#
#  id          :uuid             not null, primary key
#  profile_id  :uuid
#  location_id :uuid
#  label       :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#
