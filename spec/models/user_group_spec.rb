describe UserGroup do
end

# == Schema Information
# Schema version: 20140530064405
#
# Table name: user_groups
#
#  id               :uuid             not null, primary key
#  name             :string(255)
#  city             :string(255)
#  state_province   :string(255)
#  country          :string(255)
#  latitude         :string(255)
#  longitude        :string(255)
#  slug             :string(255)
#  homepage         :string(255)
#  twitter          :string(255)
#  description      :string(255)
#  registered_by_id :uuid             indexed
#  topics           :string(255)      is an Array
#  created_at       :datetime
#  updated_at       :datetime
#
# Indexes
#
#  index_user_groups_on_registered_by_id  (registered_by_id)
#
