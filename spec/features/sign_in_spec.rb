describe 'The Sign in Process', type: :feature do
  include_context 'shared stuff'

  before do

    User.create!(
      username: user_data[:username],
      email: user_data[:email],
      password: 'password',
      password: 'password'
    )

  end

  it 'signs me in' do
    visit root_path

    click_link('Sign in')

    # Sign in form
    fill_in('user_email', with: user_data[:email])
    fill_in('user_password', with: 'password')

    click_button('Sign in')

    expect(page).to have_content('Signed in successfully')
  end
end
