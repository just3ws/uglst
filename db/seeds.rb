PublicActivity.enabled = false

def fake_user_name
  Faker::Internet.user_name.classify.underscore
end

uglst_source = Source.find_or_create_by(name: 'User-Group List') do |m|
  m.description = 'User-Group List'
  m.homepage ='https://ugl.st'
  m.twitter = 'https://twitter.com/uglst'
end

Source.find_or_create_by(name: 'PHP.UserGroup') do |m|
  m.description = 'An international meeting-point for the PHP-Community.'
  m.homepage ='http://php.ug/'
  m.twitter = 'https://twitter.com/php_ug'
end

admin = User.find_or_create_by(email: 'mike@ugtastic.com') do |u|
  u.admin                          = true
  u.password                       = Rails.env.development? ? 'password' : (ENV['ADMIN_PASSWORD'] || SecureRandom.uuid)
  u.personal.birthday              = Date.new(1975, 12, 19).stamp('12/31/1999')
  u.personal.ethnicity             = 'Not Hispanic or Latino'
  u.personal.gender                = 'Male'
  u.personal.parental_status       = 'Parent'
  u.personal.race                  = 'White'
  u.personal.relationship_status   = 'Married'
  u.personal.religious_affiliation = 'None'
  u.personal.sexual_orientation    = 'Heterosexual'
  u.profile.address                = ENV['MIKES_ADDRESS'] || '614 18th Ave Menlo Park, CA 94025'
  u.profile.bio                    = Faker::Lorem.paragraph
  u.profile.first_name             = 'Mike'
  u.profile.homepage               = Faker::Internet.http_url
  u.profile.interests              = Faker::Skill.specialties
  u.profile.last_name              = 'Hall'
  u.profile.twitter                = 'https://twitter.com/ugtastic'
  u.username                       = 'ugtastic'
end

if Rails.env.development?
  user1 = User.find_or_create_by(email: 'user1@example.com') do |u|
    u.password           = 'password'
    u.profile.address    = '4059 Mt Lee Dr. Hollywood, CA 90068'
    u.profile.bio        = Faker::Lorem.paragraph
    u.profile.first_name = Faker::Name.first_name
    u.profile.homepage   = Faker::Internet.http_url
    u.profile.interests  = Faker::Skill.specialties
    u.profile.last_name  = Faker::Name.last_name
    u.profile.twitter    = "@#{fake_user_name}"
    u.username           = fake_user_name
  end

  user2 = User.find_or_create_by(email: 'user2@example.com') do |u|
    u.password           = 'password'
    u.profile.address    = '221 B Baker St, London, England'
    u.profile.bio        = Faker::Lorem.paragraph
    u.profile.first_name = Faker::Name.first_name
    u.profile.homepage   = Faker::Internet.http_url
    u.profile.interests  = Faker::Skill.specialties
    u.profile.last_name  = Faker::Name.last_name
    u.profile.twitter    = "@#{fake_user_name}"
    u.username           = fake_user_name
  end

  user_group = UserGroup.find_or_create_by(name: 'Software Craftsmanship McHenry County') do |ug|
    ug.city           = Faker::AddressUS.city
    ug.country        = 'US'
    ug.description    = Faker::Lorem.paragraph
    ug.homepage       = Faker::Internet.http_url
    ug.registered_by  = user1
    ug.state_province = Faker::AddressUS.state
    ug.topics         = Faker::Skill.specialties
    ug.twitter        = "@#{fake_user_name}"
    ug.source         = uglst_source
  end
  ap user_group

  ap UserGroupMembership.find_or_create_by(user_id: user1.id, user_group_id: user_group.id) do |ugm|
    ugm.relationship = 1
  end

  ap UserGroupMembership.find_or_create_by(user_id: user2.id, user_group_id: user_group.id) do |ugm|
    ugm.relationship = 0
  end

  network = Network.find_or_create_by(name: 'Software Craftsmanship Community') do |n|
    n.description   = Faker::Lorem.paragraph
    n.twitter       = "@#{fake_user_name}"
    n.registered_by = user2
  end
  ap network

  ap NetworkAffiliation.find_or_create_by(user_group_id: user_group.id, network_id: network.id)
end

PublicActivity.enabled = true
