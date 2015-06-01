FactoryGirl.define do
  factory :location do
    address 'MyText'
    city 'MyString'
    country 'MyString'
    formatted_address 'MyText'
    latitude 1.5
    longitude 1.5
    state_province 'MyString'
  end
end

# == Schema Information
#
# Table name: locations
#
#  id                :uuid             not null, primary key
#  address           :text
#  formatted_address :text
#  city              :string
#  state_province    :string
#  country           :string
#  latitude          :float
#  longitude         :float
#  created_at        :datetime
#  updated_at        :datetime
#
