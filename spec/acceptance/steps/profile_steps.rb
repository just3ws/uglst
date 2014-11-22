module ProfileSteps
  step 'I have signed out' do
    visit destroy_user_session_path
  end

  step 'I have signed up with :email' do |email|
    visit new_user_registration_path

    fill_in('Email', with: email)

    password = 'password'
    fill_in('user_password', with: password)
    fill_in('user_password_confirmation', with: password)

    click_button('Sign up')
  end

  step 'I open my profile page from the nav bar' do
    within('#nav-profile-btn') do
      first('a').click
    end

    click_button('Manage Profile')
    click_link('Edit')

  end

  step 'I create a profile with:' do |table|
    data = structify(table)

    field_labeled(data.username.key).set(data.username.value)

    # Public Info
    field_labeled(data.first_name.key).set(data.first_name.value)
    field_labeled(data.last_name.key).set(data.last_name.value)
    fill_in(data.bio.key, with: data.bio.value)

    # Online Info
    fill_in(data.homepage.key, with: data.homepage.value)

    VCR.use_cassette("twitter_lookup_for#{data.twitter.symbol}", record: :new_episodes) do
      fill_in(data.twitter.key, with: data.twitter.value)
    end

    # Geographic Info
    fill_in(data.address.key, with: data.address.value)

    page.find('body').click # Force the address field to lose focus.
  end

  step 'I should see a profile with:' do |table|
    data = structify(table)

    user = User.find_by(username: 'ugtastic')

    visit profile_path(user)

    screenshot_and_open_image

    expect(page).to have_content(data.name.value)
    expect(page).to have_content(data.address.value)
    expect(page).to have_content(data.bio.value)
  end
end
