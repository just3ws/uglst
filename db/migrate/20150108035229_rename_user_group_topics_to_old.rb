# frozen_string_literal: true
class RenameUserGroupTopicsToOld < ActiveRecord::Migration
  def change
    rename_column :user_groups, :topics, :old
  end
end
