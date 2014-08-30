RSpec.describe Network, type: :model do
  it { should be_a(Twitterable) }
end

# == Schema Information
# Schema version: 20140830050619
#
# Table name: networks
#
#  id               :uuid             not null, primary key
#  registered_by_id :uuid
#  homepage         :string(255)
#  name             :text
#  slug             :string(255)
#  twitter          :string(255)
#  description      :text
#  logo             :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#
