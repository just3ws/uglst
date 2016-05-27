# frozen_string_literal: true
class CreateUserGroupLocations < ActiveRecord::Migration
  def change
    create_table(:user_group_locations, id: :uuid) do |t|
      t.uuid :user_group_id
      t.uuid :location_id

      t.timestamps
    end
  end
end
