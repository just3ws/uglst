# frozen_string_literal: true
describe UserGroup do
  let(:user_group) do
    ug = UserGroup.create(
      name: 'Test User-Group',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor '
    )
    ug.location = Location.find_or_create_by(address: '101 North Main Street, Crystal Lake, IL 60014')

    ug
  end

  it { expect(user_group).to be_valid }

  context 'shortname is blank' do
    before do
      user_group.shortname = nil
    end
  end

  context 'no address is provided' do
    it '#address' do
      expect(user_group.location.city).to eq('Crystal Lake')
      expect(user_group.location.country).to eq('US')
      expect(user_group.location.state_province).to eq('Illinois')
    end
  end

  context 'minimum valid address is set' do
  end
end
