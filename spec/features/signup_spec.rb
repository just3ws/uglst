describe 'The Signup Process', type: :feature do
  it "let's me create a new account" do

    data = { username: Faker::Internet.user_name.classify.underscore }

    sign_up_steps(data)

    expect(page).to have_content('Welcome! You have signed up successfully.')
    within ('#nav-profile-btn') { expect(page).to have_content(data[:username]) }
  end
end

def sign_up_steps(data)
  visit root_path

  click_link('Sign up')

  fill_in('Username', with: data[:username])
  fill_in('Email', with: Faker::Internet.email)
  password = 'password'
  fill_in('user_password', with: password)
  fill_in('user_password_confirmation', with: password)

  click_button('Sign up')
end
