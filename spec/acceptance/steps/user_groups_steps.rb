module UserGroupsSteps
  step 'I follow the :link_text link in the navbar' do |link_text|
    within('.navbar') { click_link(link_text) }
  end

  step 'I should see :message' do |message|
    expect(page).to have_content(message)
  end

  step 'I am logged in and on the User-Group registration form' do
    step 'I am a logged in user'
    step 'I follow the "Register a User-Group!" link in the navbar'
  end

  step 'I enter a new User-Group with:' do |table|
    data = structify(table)

    field_labeled(data.name.key).set(data.name.value)
    field_labeled(data.description.key).set(data.description.value)
    field_labeled(data.topics.key).set(data.description.value)
    field_labeled(data.topics.key).set(data.topics.value)
    field_labeled(data.homepage.key).set(data.homepage.value)
    field_labeled(data.twitter.key).set(data.twitter.value)
    field_labeled(data.city.key).set(data.city.value)
    field_labeled(data.country.key).set(data.country.value)
  end

  step 'I click the :button_text button' do |button_text|
    click_button(button_text)
  end

  step 'the Twitter account for :user_group_name is set to :screen_name' do |user_group_name, screen_name|
    ug = UserGroup.find_by(name: user_group_name)
    expect(ug.twitter.to_s).to eq(screen_name)

  end

  step 'the Homepage for :user_group_name is set to :homepage' do |user_group_name, homepage|
    expect(find_link("#{user_group_name} Homepage")[:href]).to eq(homepage)
  end
end
