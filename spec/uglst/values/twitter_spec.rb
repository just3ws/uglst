describe Uglst::Values::Twitter do
  subject { Uglst::Values::Twitter }

  it 'can handle nil twitter name' do
    expect { subject.new(screen_name: nil).to_s }.to raise_error('Cannot extract a screen_name from nil.')
  end

  it 'can handle empty twitter name' do
    expect { subject.new(screen_name: '').to_s }.to raise_error('Cannot extract a screen_name from a blank string.')
  end

  it 'can parse a valid twitter account url' do
    twitter_account = subject.new(screen_name: 'Https://twitter.com/ugLst')
    expect(twitter_account.to_i).to eq(450_382_927)
    expect(twitter_account.user_id).to eq(450_382_927)

    expect(twitter_account.screen_name).to eq('uglst')
  end

  it 'can compare two accounts' do
    expect(subject.new(screen_name: 'uglst')).to eq(subject.new(screen_name: 'uglst'))
  end

  it 'implements comparable methods' do

    uglst = subject.new(screen_name: 'uglst')
    just3ws = subject.new(screen_name: 'just3ws', user_id: 15_746_419)

    expect(uglst).to be > just3ws
    expect(uglst).to be >= just3ws
    expect(just3ws).to be < uglst
    expect(just3ws).to be <= uglst

    arr = [just3ws, uglst]
    expect(arr.min).to eq(just3ws)
    expect(arr.max).to eq(uglst)

    uglst2 = subject.new(screen_name: uglst.screen_name, user_id: uglst.user_id)
    expect(uglst).to eq(uglst2)
    expect(uglst).to eql(uglst2)

    expect(uglst).to_not be(uglst2)
    expect(uglst).to_not equal(uglst2)
  end

  it 'can be used as hash keys' do
    uglst = subject.new(screen_name: 'uglst')
    just3ws = subject.new(screen_name: 'just3ws', user_id: 15_746_419)

    expect({ uglst => 1 }.values).to eq([1])
    expect({ uglst => 1, uglst => 2 }.values).to eq([2])
    expect({ uglst => 1, just3ws => 2 }.values).to eq([1, 2])
    expect({ uglst => 1, just3ws => 2 }.merge(uglst => 3, just3ws => 4).values).to eq([3, 4])
  end
end
