# frozen_string_literal: true
class CreateLocations < ActiveRecord::Migration
  def change
    create_table(:locations, id: :uuid) do |t|
      t.text :address
      t.text :formatted_address, index: true

      t.string :city, index: true
      t.string :state_province, index: true
      t.string :country, index: true

      t.float :latitude
      t.float :longitude

      t.timestamps
    end

    add_index :locations, %i(latitude longitude)
  end
end
