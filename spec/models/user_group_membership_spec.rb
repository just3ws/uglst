RSpec.describe UserGroupMembership, type: :model do
end

# == Schema Information
# Schema version: 20140726033553
#
# Table name: user_group_memberships
#
#  id            :uuid             not null, primary key
#  user_id       :uuid
#  user_group_id :uuid
#  relationship  :integer          default(0)
#  created_at    :datetime
#  updated_at    :datetime
#
