describe UserGroup do
end

# == Schema Information
# Schema version: 20140609184344
#
# Table name: user_groups
#
#  id                :uuid             not null, primary key
#  registered_by_id  :uuid
#  homepage          :string(255)
#  name              :string(255)
#  slug              :string(255)
#  twitter           :string(255)
#  description       :text
#  topics            :text             is an Array
#  address           :text
#  formatted_address :text
#  city              :string(255)
#  state_province    :string(255)
#  country           :string(255)
#  latitude          :string(255)
#  longitude         :string(255)
#  logo              :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#
