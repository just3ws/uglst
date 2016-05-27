# frozen_string_literal: true
class AddMeetupNameToUserGroup < ActiveRecord::Migration
  def change
    add_column :user_groups, :meetup, :string
    add_index :user_groups, :meetup, unique: true
  end
end
