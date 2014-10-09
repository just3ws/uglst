Given /^I am not logged in$/i do

  visit '/users/sign_out'
end

Given /^there are no user-groups registered$/i do
  expect(UserGroup.count).to be_zero
end

When /^I'm on the home page$/i do
  visit root_path
end

Then /^I should see nothing$/i do
end

Then /^show me the page$/i do
  save_and_open_page
end

When /^I click "Register your User-Group"$/i do
  click_link('register-your-user-group')
end

Then /^I should see the login page$/i do
  expect(page).to have_content('You need to sign in or sign up before continuing.')
end

When /^I click "Sign up"$/i do
  within('.well') { click_link('Sign up') }
end

Then /^I should see the sign up page$/i do
  expect(page).to have_content('Sign up is free and will give you access to add and join user-groups')
end

Then /^I sign up$/i do
  fill_in('Username', with: 'testtest')
  fill_in('Email', with: 'test@test.com')
  password = 'password'
  fill_in('user_password', with: password)
  fill_in('user_password_confirmation', with: password)

  click_button('Sign up')
end
