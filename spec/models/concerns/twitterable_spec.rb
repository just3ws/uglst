describe Twitterable do
  it 'handles an empty twitter name' do
    expect(Twitterable.parse(nil)).to eq nil
    expect(Twitterable.parse('   ')).to eq nil
  end

  it 'handles a twitter url' do
    expect(Twitterable.parse('Https://twitter.com/usernaMe')).to eq 'username'
    expect(Twitterable.parse('http://twitter.com/USERNAME')).to eq 'username'
    expect(Twitterable.parse('HTTP://WWW.TWITTER.COM/USERNAME')).to eq 'username'
    expect(Twitterable.parse('https://www.TWITTER.com/username')).to eq 'username'
  end

  it 'handles an @name' do
    expect(Twitterable.parse('@UserName')).to eq 'username'
  end

  it 'handles an username' do
    expect(Twitterable.parse('Username')).to eq 'username'
  end
end
