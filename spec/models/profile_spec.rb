describe Profile do
  it { should be_a(Twitterable) }

  let (:user) { User.create(email: 'test@example.com', password: 'password', password_confirmation: 'password', username: 'testuser') }
  let (:profile) { Profile.new(user: user, first_name: 'hello', last_name: 'goodbye') }

  it { expect(profile).to be_valid }

  it '#full_name' do
    expect(profile.full_name).to eq('hello goodbye')
  end

  context 'geocode queries' do
    it 'geocodes by city and country' do
      profile = Profile.create(address: 'Chicago, US')
      expect(profile.formatted_address).to eq('Chicago, IL, USA')
      expect(profile.city).to eq('Chicago')
      expect(profile.country).to eq('US')
      expect(profile.address).to eq('Chicago, US')
      expect(profile.latitude).to eq(41.8781136)
      expect(profile.longitude).to eq(-87.6297982)
    end
  end

  context 'full_name is present' do
    it '#full_name_or_username' do
      expect(profile.full_name_or_username).to eq('hello goodbye')
    end
  end

  context 'full_name is blank' do
    before do
      profile.first_name = nil
      profile.last_name = nil
    end

    it '#full_name_or_username' do
      expect(profile.full_name_or_username).to eq('testuser')
    end
  end
end
