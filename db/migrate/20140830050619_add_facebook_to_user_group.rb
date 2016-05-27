# frozen_string_literal: true
class AddFacebookToUserGroup < ActiveRecord::Migration
  def change
    add_column :user_groups, :facebook, :string
    add_index :user_groups, :facebook, unique: true
  end
end
