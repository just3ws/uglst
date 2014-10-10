describe 'The Sign up Process', type: :feature do
  include_context 'shared stuff'

  it "let's me create a new account" do
    sign_up_steps(user_data)

    expect(page).to have_content('Welcome! You have signed up successfully.')
    within('#nav-profile-btn') { expect(page).to have_content(user_data[:username]) }
  end
end
