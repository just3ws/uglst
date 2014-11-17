require 'ostruct'

module ProfileSteps
  step 'I have signed out' do
    visit destroy_user_session_path
  end

  step 'I have signed up with :email' do |email|
    visit new_user_registration_path

    fill_in('Email', with: email)

    password = 'password'
    fill_in('user_password', with: password)
    fill_in('user_password_confirmation', with: password)

    click_button('Sign up')
  end

  step 'I open my profile page from the nav bar' do
    within('#nav-profile-btn') do
      first('a').click
    end

    click_button('Manage Profile')
    click_link('Edit')

  end

  step 'I create a profile with:' do |table|
    data = structify(table)

    sleep 1

    # Public Info
    field_labeled(data.first_name.key).set(data.first_name.value)
    field_labeled(data.first_name.key).trigger(:blur)


    #fill_in(data.last_name.key, with: data.last_name.value).trigger(:blur)
    #field_labeled(data.last_name.key).trigger(:blur)

    #fill_in(data.bio.key, with: data.bio.value).trigger(:blur)
    #field_labeled(data.bio.key).trigger(:blur)


    ## Online Info
    #fill_in(data.homepage.key, with: data.homepage.value)
    #VCR.use_cassette("twitter_lookup_for#{data.twitter.symbol}", record: :new_episodes) do
    #fill_in(data.twitter.key, with: data.twitter.value)
    #end

    ## Geographic Info
    #fill_in(data.address.key, with: data.address.value)

    #click_button('Save Profile')
    #end
  end

  step 'Then I should see a profile with:' do |table|
    data = structify(table)

    expect(page).to have_content(data.name.value)
    expect(page).to have_content(data.address.value)
    expect(page).to have_content(data.bio.value)

  end

  def structify(table, key='key', value='value')
    OpenStruct.new(table.hashes.reduce({}) do |memo, hash|
      k = hash[key]
      v = hash[value]

      k_sym = k.strip.downcase.underscore.gsub(/\s+/, '_').gsub(/_+/, '_')

      memo[k_sym] = OpenStruct.new(value: v, symbol: k_sym, key: k)

      memo
    end)
  end
end
