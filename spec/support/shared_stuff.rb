# frozen_string_literal: true
RSpec.shared_context 'shared stuff' do
  let(:username) { Faker::Internet.user_name.classify.underscore }

  let(:user_data) do
    {
      username: username,
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      bio: Faker::Lorem.paragraph,
      homepage: Faker::Internet.http_url,
      twitter: 'https://twitter.com/example',
      address: '1060 West Addison Street, Chicago, IL 60613',
      email: Faker::Internet.email
    }
  end

  let(:user_group_data) do
    {
      name: 'My User-Group',
      description: Faker::Lorem.paragraph,
      homepage: Faker::Internet.http_url,
      twitter: 'https://twitter.com/example2',
      city: 'Chicago',
      country: 'United States'
    }
  end
end

def sign_up_steps(user_data)
  visit root_path

  click_link('Sign up')

  fill_in('Username', with: user_data[:username])
  fill_in('Email', with: user_data[:email])
  password = 'password'
  fill_in('user_password', with: password)
  fill_in('user_password_confirmation', with: password)

  click_button('Sign up')
end

def sign_up_and_create_profile(user_data)
  sign_up_steps(user_data)
  profile_update_steps(user_data)

  click_button('Save Profile')
end

def profile_update_steps(user_data)
  click_link(user_data[:username])

  click_button('Manage Profile')
  click_link('Edit')

  # Public Info
  fill_in('Preferred name', with: "#{user_data[:first_name]} #{user_data[:last_name]}")
  fill_in('Bio', with: user_data[:bio])

  # Online Info
  fill_in('Homepage', with: user_data[:homepage])
  fill_in('Twitter', with: user_data[:twitter])

  # Geographic Info
  fill_in('Address', with: user_data[:address])
end
