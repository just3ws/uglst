require 'rails_helper'

describe Profile do
  it { should be_a(Twitterable) }

  let(:profile) do
    Profile.new(first_name: 'hello', last_name: 'goodbye')
  end

  it '#full_name' do
    expect(profile.full_name).to eq('hello goodbye')
  end

  it '#full_name_or_username' do
    expect(profile.full_name_or_username).to eq('hello goodbye')
  end
end
