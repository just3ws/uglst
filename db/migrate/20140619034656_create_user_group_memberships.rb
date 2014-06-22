class CreateUserGroupMemberships < ActiveRecord::Migration
  def change
    create_table(:user_group_memberships , id: :uuid) do |t|
      t.uuid :user_id
      t.uuid :user_group_id

      t.integer :relationship, default: 1 # Membership => 1, Organizer => 2

      t.timestamps
    end
    add_index :user_group_memberships, :user_id
    add_index :user_group_memberships, :user_group_id
    add_index :user_group_memberships, [:user_id, :user_group_id]
    add_index :user_group_memberships, :relationship
  end
end
