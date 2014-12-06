require 'rails_helper'

describe UserGroup do
  let(:user_group) {
    UserGroup.new(
      city: 'Chicago',
      country: 'US',
      name: 'Test User-Group',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor '
    )
  }

  it { expect(user_group).to be_valid }

  context 'shortname is present' do
    before {
      user_group.shortname = 'hello'
    }

    it '#slug_candidates' do
      expect(user_group.slug_candidates).to eq([
        :shortname,
        [:shortname, :city],
        [:shortname, :city, :state_province],
        [:shortname, :city, :state_province, :country]
      ])
    end
  end

  context 'shortname is blank' do
    before {
      user_group.shortname = nil
    }

    it '#slug_candidates' do
      expect(user_group.slug_candidates).to eq([
        :name,
        [:name, :city],
        [:name, :city, :state_province],
        [:name, :city, :state_province, :country]
      ])
    end
  end

  context 'no address is provided' do
    it '#address' do
      expect(user_group.address).to eq('Chicago, US')
    end
  end

  context 'minimum valid address is set' do

  end
end
