class DropRolesAndUserRoles < ActiveRecord::Migration
  def change
    remove_index(:roles, :name)
    remove_index(:roles, [:name, :resource_type, :resource_id])
    remove_index(:users_roles, [:user_id, :role_id])

    drop_table :users_roles
    drop_table :roles
  end
end
