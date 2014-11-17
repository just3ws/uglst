describe 'Profile Management', type: :feature, skip: true do
  include_context 'shared stuff'

  it 'lets me manage my profile', skip: true do
    sign_up_and_create_profile(user_data)

    expect(page).to have_content("#{user_data[:first_name]} #{user_data[:last_name]}")
    expect(page).to have_content('Chicago, Illinois US')
    expect(page).to have_content(user_data[:bio])
  end
end
