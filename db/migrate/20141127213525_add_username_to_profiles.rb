# frozen_string_literal: true
class AddUsernameToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :username, :string
    add_index :profiles, :username, unique: true
  end
end
