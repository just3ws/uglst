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
