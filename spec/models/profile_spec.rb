describe Profile do
  let(:user) do
    User.create(
      email: 'test@example.com',
      password: 'password',
      password_confirmation: 'password',
      username: 'testuser'
    )
  end

  let(:profile) do
    Profile.create(
      user: user,
      preferred_name: 'Mike Hall',
      address: 'Chicago, IL USA'
    )
  end

  it { expect(profile).to be_valid }

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

  context 'preferred_name is present' do
    it '#preferred_name_or_username' do
      expect(profile.preferred_name_or_username).to eq('Mike Hall')
    end
  end

  context 'preferred_name is blank' do
    before do
      profile.first_name = nil
      profile.last_name = nil
    end

    it '#preferred_name_or_username' do
      expect(profile.preferred_name_or_username).to eq('Mike Hall')
    end
  end
end
