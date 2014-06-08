admin = User.find_or_create_by(email: 'mike@ugtastic.com') do |u|
  u.address               = '614 18th Ave Menlo Park, CA 94025'
  u.admin                 = true
  u.birthday              = Date.new(1975, 12, 19).stamp('12/31/1999')
  u.ethnicity             = 'Not Hispanic or Latino'
  u.first_name            = 'Mike'
  u.gender                = 'Male'
  u.homepage              = Faker::Internet.http_url
  u.interests             = Faker::Skill.specialties
  u.last_name             = 'Hall'
  u.parental_status       = 'Parent'
  u.password              = Rails.env.development? ? 'password' : SecureRandom.uuid
  u.race                  = 'White'
  u.relationship_status   = 'Married'
  u.religious_affiliation = 'None'
  u.sexual_orientation    = 'Heterosexual'
  u.twitter               = 'https://twitter.com/ugtastic'
  u.username              = 'ugtastic'
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
