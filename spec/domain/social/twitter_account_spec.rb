describe Domain::Social::TwitterAccount do
  it 'can handle nil twitter name' do
    expect(Domain::Social::TwitterAccount.new(nil).to_s).to eq('')
  end

  it 'can handle empty twitter name' do
    expect(Domain::Social::TwitterAccount.new('').to_s).to eq('')
  end

  it 'can parse a valid twitter account url' do
    VCR.use_cassette('twitter_account for uglst', record: :new_episodes) do
      twitter_account = Domain::Social::TwitterAccount.new('Https://twitter.com/ugLst')
      expect(twitter_account.user_id).to eq(450382927)
      expect(twitter_account.screen_name).to eq('uglst')
    end
  end
end

