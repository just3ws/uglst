class NetworkAffiliation < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: proc { |controller, _model| controller.current_user }

  belongs_to :network
  belongs_to :user_group

  validates :network, presence: true
  validates :user_group, presence: true
end

# == Schema Information
# Schema version: 20140628174646
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
