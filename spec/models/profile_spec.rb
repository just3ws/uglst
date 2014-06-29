RSpec.describe Profile, type: :model do
  it { should be_a(Twitterable) }
end

# == Schema Information
# Schema version: 20140628174646
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
#  latitude          :float            indexed => [longitude]
#  longitude         :float            indexed => [latitude]
#  created_at        :datetime         indexed
#  updated_at        :datetime
#
# Indexes
#
#  index_profiles_on_created_at              (created_at)
#  index_profiles_on_latitude_and_longitude  (latitude,longitude)
#
