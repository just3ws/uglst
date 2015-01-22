module AuthenticationSteps
  step 'I am an admin' do
    User.create!(
        username: 'administrator',
        password: 'password',
        password_confirmation: 'password',
        email: 'admin@example.com',
        admin: true
    )
  end

  step 'I am logged in as an admin' do
    step 'I am an admin'
    step 'I visit the sign in page'
    step 'I sign in with "admin@example.com" and "password"'
  end

  step 'I am a member with:' do |table|
    data = structify(table)

    User.create!(
        email: data.email.value,
        password: data.password.value,
        password_confirmation: data.password.value
    )
  end

  step 'I visit the sign in page' do
    visit(new_user_session_path)
  end

  step 'I sign in with :email and :password' do |email, password|
    fill_in('user_email', with: email)
    fill_in('user_password', with: password)

    click_button('Sign in')
  end

  step 'I am a logged in user' do
    user = User.create!(
        username: 'turnip',
        password: 'password',
        password_confirmation: 'password',
        email: 'turnip@example.com'
    )

    visit new_user_session_path

    fill_in('user_email', with: user.email)
    fill_in('user_password', with: user.password)

    click_button('Sign in')
  end
end
