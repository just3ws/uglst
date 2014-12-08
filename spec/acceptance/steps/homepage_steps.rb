module HomepageSteps
  step 'I visit the homepage' do
    visit root_path
  end

  step 'I fill out the registration form with:' do |table|
    data = structify(table)

    field_labeled(data.email.key).set(data.email.value)
    field_labeled(data.password.key).set(data.password.value)
    field_labeled(data.password_confirmation.key).set(data.password_confirmation.value)
  end

  step 'I submit the registration form' do
    click_button('Sign up')
  end

  step 'I should see the User-Group Index' do
  end

  step 'I see the User-Group Index is empty' do
    expect(page).to have_content('Uh, oh! Looks like there are no User-Groups registered!')
  end

  step 'I should see that my username is :username' do |username|
    within('#nav-profile-btn') do
      expect(page).to have_content(username)
    end
  end
end
