class UserGroupMembership < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: proc { |controller, _model| controller.current_user }

  enum relationship: %i(member organizer founder)

  belongs_to :user
  belongs_to :user_group

  validates :user, presence: true
  validates :user_group, presence: true
end

# == Schema Information
# Schema version: 20140622214224
#
# Table name: user_group_memberships
#
#  id            :uuid             not null, primary key
#  user_id       :uuid             indexed, indexed => [user_group_id]
#  user_group_id :uuid             indexed, indexed => [user_id]
#  relationship  :integer          default(0), indexed
#  created_at    :datetime
#  updated_at    :datetime
#
# Indexes
#
#  index_user_group_memberships_on_relationship               (relationship)
#  index_user_group_memberships_on_user_group_id              (user_group_id)
#  index_user_group_memberships_on_user_id                    (user_id)
#  index_user_group_memberships_on_user_id_and_user_group_id  (user_id,user_group_id)
#
