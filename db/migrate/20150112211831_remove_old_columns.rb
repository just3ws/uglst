class RemoveOldColumns  < ActiveRecord::Migration
  def change
    remove_column :user_groups, :old
    remove_column :user_groups, :twitter

    remove_column :profiles, :old
    remove_column :profiles, :twitter
  end
end
