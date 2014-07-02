RSpec.describe NetworkAffiliation, type: :model do
end

# == Schema Information
# Schema version: 20140701165803
#
# Table name: network_affiliations
#
#  id            :uuid             not null, primary key
#  network_id    :uuid             indexed, indexed => [user_group_id]
#  user_group_id :uuid             indexed => [network_id], indexed
#  created_at    :datetime
#  updated_at    :datetime
#
# Indexes
#
#  index_network_affiliations_on_network_id                    (network_id)
#  index_network_affiliations_on_network_id_and_user_group_id  (network_id,user_group_id)
#  index_network_affiliations_on_user_group_id                 (user_group_id)
#
