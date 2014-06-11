admin = User.find_or_create_by(email: 'mike@ugtastic.com') do |u|
  u.address    = ENV['MIKES_ADDRESS'] || '614 18th Ave Menlo Park, CA 94025'
  u.admin      = true
  u.bio        = Faker::Lorem.paragraph
  u.first_name = 'Mike'
  u.homepage   = Faker::Internet.http_url
  u.interests  = Faker::Skill.specialties
  u.last_name  = 'Hall'
  u.password   = Rails.env.development? ? 'password' : (ENV['ADMIN_PASSWORD'] || SecureRandom.uuid)
  u.twitter    = 'https://twitter.com/ugtastic'
  u.username   = 'ugtastic'

  u.personal.birthday              = Date.new(1975, 12, 19).stamp('12/31/1999')
  u.personal.ethnicity             = 'Not Hispanic or Latino'
  u.personal.gender                = 'Male'
  u.personal.parental_status       = 'Parent'
  u.personal.race                  = 'White'
  u.personal.relationship_status   = 'Married'
  u.personal.religious_affiliation = 'None'
  u.personal.sexual_orientation    = 'Heterosexual'
end

puts ' --- admin --- '
ap admin

if Rails.env.development?
  user = User.find_or_create_by(email: 'development@example.com') do |u|
    u.address    = '4059 Mt Lee Dr. Hollywood, CA 90068'
    u.bio        = Faker::Lorem.paragraph
    u.first_name = Faker::Name.first_name
    u.homepage   = Faker::Internet.http_url
    u.interests  = Faker::Skill.specialties
    u.last_name  = Faker::Name.last_name
    u.password   = 'password'
    u.twitter    = "@#{Faker::Internet.user_name}"
    u.username   = Faker::Internet.user_name
  end

  puts ' --- user --- '
  ap user

  user_group = UserGroup.find_or_create_by(name: 'Software Craftsmanship McHenry County') do |ug|
    ug.city           = Faker::AddressUS.city
    ug.country        = 'US'
    ug.description    = Faker::Lorem.paragraph
    ug.homepage       = Faker::Internet.http_url
    ug.registered_by  = user
    ug.state_province = Faker::AddressUS.state
    ug.topics         = Faker::Skill.specialties
    ug.twitter        = "@#{Faker::Internet.user_name}"
  end

  puts ' --- user_group --- '
  ap user_group
end
