RSpec.describe Opportunity, :type => :model do
  it 'starts as a draft' do
    expect(Opportunity.new.draft?).to eq(true)
  end
end
