class RenameProfileInterestsToOld < ActiveRecord::Migration
  def change
    rename_column :profiles, :interests, :old
  end
end
