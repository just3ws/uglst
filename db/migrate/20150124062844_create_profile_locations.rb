# frozen_string_literal: true
class CreateProfileLocations < ActiveRecord::Migration
  def change
    create_table(:profile_locations, id: :uuid) do |t|
      t.uuid :profile_id
      t.uuid :location_id

      t.string :label # home, work

      t.timestamps
    end
  end
end
