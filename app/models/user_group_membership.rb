class UserGroupMembership < ActiveRecord::Base
  enum relationship: %i[member organizer]

  belongs_to :user
  belongs_to :user_group
end
