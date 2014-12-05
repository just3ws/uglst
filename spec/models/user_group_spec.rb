require 'rails_helper'

describe UserGroup do
  let(:user_group) do
    UserGroup.new(shortname: 'hello')
  end

  it '#slug_candidates' do
    expect(user_group.slug_candidates).to eq([
      :shortname,
      [:shortname, :city],
      [:shortname, :city, :state_province],
      [:shortname, :city, :state_province, :country]
    ])
  end

  it '#address' do
    expect(user_group.address).to eq(nil)
  end
end
