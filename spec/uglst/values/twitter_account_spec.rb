describe Uglst::Values::TwitterAccount do
  subject { Uglst::Values::TwitterAccount }

  it 'can handle nil twitter name' do
    expect(subject.from_twitter_string(nil).to_s).to eq('')
  end

  it 'can handle empty twitter name' do
    expect(subject.from_twitter_string('').to_s).to eq('')
  end

  it 'can parse a valid twitter account url' do
    VCR.use_cassette('twitter_account for uglst', record: :new_episodes) do
      twitter_account = subject.from_twitter_string('Https://twitter.com/ugLst')
      expect(twitter_account.to_s).to eq('450382927')
      expect(twitter_account.user_id).to eq(450_382_927)
      expect(twitter_account.screen_name).to eq('uglst')
    end
  end

  it 'can compare two accounts' do
    VCR.use_cassette('compare two twitter_accounts', record: :new_episodes) do
      expect(subject.new('uglst')).to eq(subject.from_twitter_string('uglst'))
    end
  end

  it 'implements comparable methods' do
    VCR.use_cassette('lookup_user_id_for uglst', record: :new_episodes) do

      uglst = subject.new('uglst')
      just3ws = subject.new('just3ws', 15_746_419)

      expect(uglst).to be > just3ws
      expect(uglst).to be >= just3ws
      expect(just3ws).to be < uglst
      expect(just3ws).to be <= uglst

      arr = [just3ws, uglst]
      expect(arr.min).to eq(just3ws)
      expect(arr.max).to eq(uglst)

      uglst2 = subject.new(uglst.screen_name, uglst.user_id)
      expect(uglst).to eq(uglst2)
      expect(uglst).to eql(uglst2)

      expect(uglst).to_not be(uglst2)
      expect(uglst).to_not equal(uglst2)
    end
  end

  it 'can be used as hash keys' do
    VCR.use_cassette('lookup_user_id_for uglst', record: :new_episodes) do
      uglst = subject.new('uglst')
      just3ws = subject.new('just3ws', 15_746_419)

      expect({ uglst => 1 }.values).to eq([1])
      expect({ uglst => 1, uglst => 2 }.values).to eq([2])
      expect({ uglst => 1, just3ws => 2 }.values).to eq([1, 2])
      expect({ uglst => 1, just3ws => 2 }.merge(uglst => 3, just3ws => 4).values).to eq([3, 4])
    end
  end
end
