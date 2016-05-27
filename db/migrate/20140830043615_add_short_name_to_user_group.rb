# frozen_string_literal: true
class AddShortNameToUserGroup < ActiveRecord::Migration
  def change
    add_column :user_groups, :shortname, :string
    add_index :user_groups, :shortname, unique: true
  end
end
