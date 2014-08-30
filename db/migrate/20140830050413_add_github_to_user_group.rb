class AddGithubToUserGroup < ActiveRecord::Migration
  def change
    add_column :user_groups, :github, :string
    add_index :user_groups, :github, unique: true
  end
end
