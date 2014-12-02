module AuthenticationSteps
  step 'I am a member with:' do |table|
    data = structify(table)

    User.find_or_create_by(email: data.email.value) do |u|
      u.password = data.password.value
      u.password_confirmation = data.password.value
    end
  end

  step 'I visit the sign in page' do
    visit new_user_session_path
  end

  step 'I sign in with :email and :password' do |email, password|
    fill_in('user_email', with: email)
    fill_in('user_password', with: password)

    click_button('Sign in')
  end
end