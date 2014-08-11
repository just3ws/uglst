describe 'Profile Management', type: :feature do
  it "let's me manage my profile" do

    data = {
      username: Faker::Internet.user_name.classify.underscore,
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      bio: Faker::Lorem.paragraph,
      homepage: Faker::Internet.http_url,
      twitter: "https://twitter.com/#{Faker::Internet.user_name.classify.underscore}",
      address: '1060 West Addison Street, Chicago, IL 60613'
    }

    sign_up_steps(data)
    profile_update_steps(data)


    VCR.use_cassette('profile_management', record: :new_episodes) do
      click_button('Save Profile')
    end

    expect(page).to have_content("#{data[:first_name]} #{data[:last_name]}")
    expect(page).to have_content('Chicago, Illinois US')
    expect(page).to have_content(data[:bio])
  end
end

def profile_update_steps(data)
  click_link(data[:username])

  click_button('Manage Profile')
  click_link('Edit')

  # Public Info
  fill_in('First name', with: data[:first_name])
  fill_in('Last name', with: data[:last_name])
  fill_in('Bio', with: data[:bio])

  # Online Info
  fill_in('Homepage', with: data[:homepage])
  fill_in('Twitter', with: data[:twitter])

  # Geographic Info
  fill_in('Address', with: data[:address])
end
