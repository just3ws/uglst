describe 'User-Group management', type: :feature do
  include_context 'shared stuff'

  before do
    sign_up_and_create_profile(user_data)

    @user = User.find_by(username: username)
  end

  it 'can register a new user-group' do
    visit new_user_group_path

    # User-Group Info
    fill_in 'Name', with: user_group_data[:name]
    fill_in 'Description', with: user_group_data[:description]

    # Online Info
    fill_in 'Homepage', with: user_group_data[:homepage]

    # Geographic Info
    fill_in 'City', with: user_group_data[:city]
    fill_in 'Country', with: user_group_data[:country]

    # VCR.use_cassette('user_group_management', record: :new_episodes) do
    click_button('Save User-Group')
    # end

    expect(page).to have_content(user_group_data[:name])
    expect(page).to have_content("#{user_group_data[:city]}, #{user_group_data[:country]}")
    expect(page).to have_content(user_group_data[:description])
    link_text = "#{user_group_data[:name]} Homepage"
    expect(page).to have_content(link_text)
    expect(find_link(link_text)[:href]).to eq(user_group_data[:homepage])
  end
end
