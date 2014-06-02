admin = User.find_or_create_by(email: 'mike@ugtastic.com') do |u|
  u.admin = true
  u.city = 'Crystal Lake'
  u.country = 'US'
  u.homepage = Faker::Internet.http_url
  u.interests = Faker::Skill.specialties
  u.name = 'Mike Hall'
  u.password = Rails.env.development? ? 'password' : SecureRandom.uuid
  u.postal_code = '60039-1303'
  u.state_province = 'IL'
  u.street = 'PO Box 1303'
  u.twitter = 'https://twitter.com/ugtastic'
  u.username = 'ugtastic'
end

if Rails.env.development?
  user = User.find_or_create_by(email: 'development@example.com') do |u|
    u.bio = Faker::Lorem.paragraph
    u.city = Faker::AddressUS.city
    u.country = 'US'
    u.homepage = Faker::Internet.http_url
    u.interests = Faker::Skill.specialties
    u.name = Faker::Name.name
    u.password = 'password'
    u.postal_code = Faker::AddressUS.zip_code
    u.state_province =  Faker::AddressUS.state
    u.street = Faker::AddressUS.street_address
    u.twitter = "@#{Faker::Internet.user_name}"
    u.username = 'development'
  end

  user_group = UserGroup.find_or_create_by(name: 'Software Craftsmanship McHenry County') do |ug|
    ug.city = Faker::AddressUS.city
    ug.country = 'US'
    ug.description = Faker::Lorem.paragraph
    ug.homepage = Faker::Internet.http_url
    ug.registered_by = user
    ug.state_province =  Faker::AddressUS.state
    ug.topics = Faker::Skill.specialties
    ug.twitter = "@#{Faker::Internet.user_name}"
  end
end
