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
