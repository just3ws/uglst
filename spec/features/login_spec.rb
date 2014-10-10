describe 'The Login Process', type: :feature do
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

    # Sign in form
    fill_in('Email', with: user_data[:email])
    fill_in('Password', with: 'password')

    click_button('Sign in')
  end
end
