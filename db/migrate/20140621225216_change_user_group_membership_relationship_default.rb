class ChangeUserGroupMembershipRelationshipDefault < ActiveRecord::Migration
  def change
    # 0 == member
    change_column :user_group_memberships, :relationship, :integer, default: 0
  end
end
