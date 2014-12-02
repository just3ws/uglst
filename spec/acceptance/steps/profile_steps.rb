module ProfileSteps
  step 'I have already signed up with :email' do |email|
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

  step 'submit the profile info form' do
    click_button('Update Profile')
  end

  step 'update my account info with:' do |table|
    data = structify(table)
    field_labeled(data.username.key).set(data.username.value)
    field_labeled(data.email.key).set(data.email.value)
    click_button('Update Account Info')
  end

  step 'create a profile with:' do |table|
    data = structify(table)

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
  end

  step 'navigate to my public profile page' do
    user = User.find_by(email: 'mike@ugtastic.com')
    visit profile_path(user)
  end

  step 'I should see a profile with:' do |table|
    data = structify(table)

    user = User.find_by(email: 'mike@ugtastic.com')

    expect(page).to have_content(data.name.value)
    expect(page).to have_content(data.address.value)
    expect(page).to have_content(data.bio.value)
  end
end
