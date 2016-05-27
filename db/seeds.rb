# frozen_string_literal: true

require 'ffaker'
PublicActivity.enabled = false

def fake_user_name
  FFaker::Internet.user_name.classify.underscore
end

def fake_us_address
  "#{FFaker::AddressUS.city}, #{FFaker::AddressUS.state}, USA"
end

User.find_or_create_by(email: 'mike@ugtastic.com') do |u|
  u.admin = true
  u.password = Rails.env.development? ? 'password' : (ENV['ADMIN_PASSWORD'] || SecureRando.uuid)

  u.profile.address = '614 18th Ave Menlo Park, CA 94025'
  u.profile.bio = FFaker::Lorem.paragraph
  u.profile.first_name = 'Mike'
  u.profile.homepage = FFaker::Internet.http_url
  FFaker::Skill.specialties.each { |interest| u.profile.interest_list.add(interest) }
  u.profile.last_name = 'Hall'
  # u.profile.twitter = Uglst::Values::Twitter.new(screen_name: 'https://twitter.com/ugtastic')

  u.username = 'ugtastic'
end

if Rails.env.development?
  rdj = User.find_or_create_by(email: 'rdj@example.com') do |u|
    u.password = 'password'
    u.profile.address = '4059 Mt Lee Dr. Hollywood, CA 90068'
    u.profile.bio = FFaker::Lorem.paragraph
    u.profile.first_name = 'Robert'
    u.profile.homepage = FFaker::Internet.http_url
    FFaker::Skill.specialties.each { |interest| u.profile.interest_list.add(interest) }
    u.profile.last_name = 'Downey'
    # u.profile.twitter = Uglst::Values::Twitter.new(screen_name: '@RobertDowneyJr')
    u.username = fake_user_name
  end

  sherlock = User.find_or_create_by(email: 'sherlock@example.com') do |u|
    u.password = 'password'
    u.profile.address = '221 B Baker St, London, England'
    u.profile.bio = FFaker::Lorem.paragraph
    u.profile.first_name = 'Sherlock'
    u.profile.homepage = FFaker::Internet.http_url
    FFaker::Skill.specialties.each { |interest| u.profile.interest_list.add(interest) }
    u.profile.last_name = 'Holmes'
    # u.profile.twitter = Uglst::Values::Twitter.new(screen_name: '@sherlockology')
    u.username = 'sherlockology'
  end

  user_group = UserGroup.find_or_create_by(name: 'Software Craftsmanship McHenry County') do |ug|
    ug.location = Location.find_or_create_by(address: fake_us_address)
    ug.description = FFaker::Lorem.paragraph
    ug.homepage = FFaker::Internet.http_url
    ug.registered_by = rdj
    FFaker::Skill.specialties.each { |topic| ug.topic_list.add(topic) }
    ug.twitter_account = TwitterAccount.find_or_create_by(screen_name: 'scmchenry')
  end
  Rails.logger.ap(user_group, :debug)

  user_group = UserGroup.find_or_create_by(name: 'Cloud Developer\'s Group') do |ug|
    ug.location = Location.find_or_create_by(address: fake_us_address)
    ug.description = FFaker::Lorem.paragraph
    ug.homepage = FFaker::Internet.http_url
    ug.registered_by = sherlock

    FFaker::Skill.specialties.each { |topic| ug.topic_list.add(topic) }
    ug.twitter_account = TwitterAccount.find_or_create_by(screen_name: 'just3ws')
  end
  Rails.logger.ap(user_group, :debug)

  user_group = UserGroup.find_or_create_by(name: 'Chicago Alt.NET') do |ug|
    ug.location = Location.find_or_create_by(address: fake_us_address)
    ug.description = FFaker::Lorem.paragraph
    ug.homepage = FFaker::Internet.http_url
    ug.registered_by = sherlock

    FFaker::Skill.specialties.each { |topic| ug.topic_list.add(topic) }

    ug.twitter_account = TwitterAccount.find_or_create_by(screen_name: 'chicagoaltnet')
  end
  Rails.logger.ap(user_group, :debug)

  user_group = UserGroup.find_or_create_by(name: 'My Awesome User-Group') do |ug|
    ug.location = Location.find_or_create_by(address: fake_us_address)
    ug.description = FFaker::Lorem.paragraph
    ug.homepage = FFaker::Internet.http_url
    ug.registered_by = rdj

    FFaker::Skill.specialties.each { |topic| ug.topic_list.add(topic) }
    ug.twitter_account = TwitterAccount.find_or_create_by(screen_name: 'just3ws')
  end
  Rails.logger.ap(user_group, :debug)

  membership = UserGroupMembership.find_or_create_by(user_id: rdj.id, user_group_id: user_group.id) do |ugm|
    ugm.relationship = 1
  end
  Rails.logger.ap(membership, :debug)

  membership = UserGroupMembership.find_or_create_by(user_id: sherlock.id, user_group_id: user_group.id) do |ugm|
    ugm.relationship = 0
  end
  Rails.logger.ap(membership, :debug)

  network = Network.find_or_create_by(name: 'Software Craftsmanship Community') do |n|
    n.description = FFaker::Lorem.paragraph

    # n.twitter = Uglst::Values::Twitter.new(screen_name: '@scna')
    n.registered_by = sherlock
  end
  Rails.logger.ap(network, :debug)

  network_affiliation = NetworkAffiliation.find_or_create_by(user_group_id: user_group.id, network_id: network.id)
  Rails.logger.ap(network_affiliation, :debug)
end

PublicActivity.enabled = true
