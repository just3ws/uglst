RSpec.shared_context 'shared stuff' do
  let (:username) { Faker::Internet.user_name.classify.underscore }
  let (:user_data) do
    {
        username: username,
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        bio: Faker::Lorem.paragraph,
        homepage: Faker::Internet.http_url,
        twitter: "https://twitter.com/#{Faker::Internet.user_name.classify.underscore}",
        address: '1060 West Addison Street, Chicago, IL 60613'
    }
  end
  let (:user_group_data) do
    {
        name: 'My User-Group',
        description: Faker::Lorem.paragraph,
        homepage: Faker::Internet.http_url,
        twitter: "https://twitter.com/#{Faker::Internet.user_name.classify.underscore}",
        city: 'Chicago',
        country: 'United States'
    }
  end
end

def sign_up_steps(user_data)
  visit root_path

  click_link('Sign up')

  fill_in('Username', with: user_data[:username])
  fill_in('Email', with: Faker::Internet.email)
  password = 'password'
  fill_in('user_password', with: password)
  fill_in('user_password_confirmation', with: password)

  click_button('Sign up')
end

def sign_up_and_create_profile(user_data)
  sign_up_steps(user_data)
  profile_update_steps(user_data)

  VCR.use_cassette('profile_management', record: :new_episodes) do
    click_button('Save Profile')
  end
end

def profile_update_steps(user_data)
  click_link(user_data[:username])

  click_button('Manage Profile')
  click_link('Edit')

  # Public Info
  fill_in('First name', with: user_data[:first_name])
  fill_in('Last name', with: user_data[:last_name])
  fill_in('Bio', with: user_data[:bio])

  # Online Info
  fill_in('Homepage', with: user_data[:homepage])
  fill_in('Twitter', with: user_data[:twitter])

  # Geographic Info
  fill_in('Address', with: user_data[:address])
end
