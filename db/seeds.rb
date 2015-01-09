PublicActivity.enabled = false

def fake_user_name
  Faker::Internet.user_name.classify.underscore
end

uglst_source = Source.find_or_create_by(name: 'User-Group List') do |m|
  m.description = 'User-Group List'
  m.homepage = 'https://ugl.st'
  # m.twitter = Uglst::Values::Twitter.new(screen_name: 'https://twitter.com/uglst')
end

Source.find_or_create_by(name: 'PHP.UserGroup') do |m|
  m.description = 'An international meeting-point for the PHP-Community.'
  m.homepage = 'http://php.ug/'
  # m.twitter = Uglst::Values::Twitter.new(screen_name: 'https://twitter.com/php_ug')
end

User.find_or_create_by(email: 'mike@ugtastic.com') do |u|
  u.admin = true
  u.password = Rails.env.development? ? 'password' : (ENV['ADMIN_PASSWORD'] || SecureRando.uuid)

  u.personal.birthday = Date.new(1975, 12, 19).stamp('12/31/1999')
  u.personal.ethnicity = 'Not Hispanic or Latino'
  u.personal.gender = 'Male'
  u.personal.parental_status = 'Parent'
  u.personal.race = 'White'
  u.personal.relationship_status = 'Married'
  u.personal.religious_affiliation = 'None'
  u.personal.sexual_orientation = 'Heterosexual'

  u.profile.address = '614 18th Ave Menlo Park, CA 94025'
  u.profile.bio = Faker::Lorem.paragraph
  u.profile.first_name = 'Mike'
  u.profile.homepage = Faker::Internet.http_url
  Faker::Skill.specialties.each { |interest| u.profile.interest_list.add(interest) }
  u.profile.last_name = 'Hall'
  # u.profile.twitter = Uglst::Values::Twitter.new(screen_name: 'https://twitter.com/ugtastic')

  u.username = 'ugtastic'
end

if Rails.env.development?
  rdj = User.find_or_create_by(email: 'rdj@example.com') do |u|
    u.password = 'password'
    u.profile.address = '4059 Mt Lee Dr. Hollywood, CA 90068'
    u.profile.bio = Faker::Lorem.paragraph
    u.profile.first_name = 'Robert'
    u.profile.homepage = Faker::Internet.http_url
    Faker::Skill.specialties.each { |interest| u.profile.interest_list.add(interest) }
    u.profile.last_name = 'Downey'
    # u.profile.twitter = Uglst::Values::Twitter.new(screen_name: '@RobertDowneyJr')
    u.username = fake_user_name
  end

  sherlock = User.find_or_create_by(email: 'sherlock@example.com') do |u|
    u.password = 'password'
    u.profile.address = '221 B Baker St, London, England'
    u.profile.bio = Faker::Lorem.paragraph
    u.profile.first_name = 'Sherlock'
    u.profile.homepage = Faker::Internet.http_url
    Faker::Skill.specialties.each { |interest| u.profile.interest_list.add(interest) }
    u.profile.last_name = 'Holmes'
    # u.profile.twitter = Uglst::Values::Twitter.new(screen_name: '@sherlockology')
    u.username = 'sherlockology'
  end

  user_group = UserGroup.find_or_create_by(name: 'Software Craftsmanship McHenry County') do |ug|
    ug.city = Faker::AddressUS.city
    ug.country = 'US'
    ug.description = Faker::Lorem.paragraph
    ug.homepage = Faker::Internet.http_url
    ug.registered_by = rdj
    ug.source = uglst_source
    ug.state_province = Faker::AddressUS.state
    Faker::Skill.specialties.each { |topic| ug.topic_list.add(topic) }
    # ug.twitter = Uglst::Values::Twitter.new(screen_name: '@scmchenry')
  end
  ap user_group

  user_group = UserGroup.find_or_create_by(name: 'Cloud Developer\'s Group') do |ug|
    ug.city = Faker::AddressUS.city
    ug.country = 'US'
    ug.description = Faker::Lorem.paragraph
    ug.homepage = Faker::Internet.http_url
    ug.registered_by = sherlock
    ug.source = uglst_source
    ug.state_province = Faker::AddressUS.state
    Faker::Skill.specialties.each { |topic| ug.topic_list.add(topic) }
    # ug.twitter = Uglst::Values::Twitter.new(screen_name: '@just3ws')
  end
  ap user_group

  user_group = UserGroup.find_or_create_by(name: 'Chicago Alt.NET') do |ug|
    ug.city = Faker::AddressUS.city
    ug.country = 'US'
    ug.description = Faker::Lorem.paragraph
    ug.homepage = Faker::Internet.http_url
    ug.registered_by = sherlock
    ug.source = uglst_source
    ug.state_province = Faker::AddressUS.state
    Faker::Skill.specialties.each { |topic| ug.topic_list.add(topic) }
    # ug.twitter = Uglst::Values::Twitter.new(screen_name: '@chicagoaltnet')
  end
  ap user_group

  user_group = UserGroup.find_or_create_by(name: 'My Awesome User-Group') do |ug|
    ug.city = Faker::AddressUS.city
    ug.country = 'US'
    ug.description = Faker::Lorem.paragraph
    ug.homepage = Faker::Internet.http_url
    ug.registered_by = rdj
    ug.source = uglst_source
    ug.state_province = Faker::AddressUS.state
    Faker::Skill.specialties.each { |topic| ug.topic_list.add(topic) }
    # ug.twitter = Uglst::Values::Twitter.new(screen_name: '@just3ws')
  end
  ap user_group

  ap UserGroupMembership.find_or_create_by(user_id: rdj.id, user_group_id: user_group.id) do |ugm|
    ugm.relationship = 1
  end

  ap UserGroupMembership.find_or_create_by(user_id: sherlock.id, user_group_id: user_group.id) do |ugm|
    ugm.relationship = 0
  end

  network = Network.find_or_create_by(name: 'Software Craftsmanship North America') do |n|
    n.description = Faker::Lorem.paragraph
    # n.twitter = Uglst::Values::Twitter.new(screen_name: '@scna')
    n.registered_by = sherlock
  end
  ap network

  ap NetworkAffiliation.find_or_create_by(user_group_id: user_group.id, network_id: network.id)
end

PublicActivity.enabled = true
