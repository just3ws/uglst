# frozen_string_literal: true
class CreateProfiles < ActiveRecord::Migration
  def change
    create_table(:profiles, id: :uuid) do |t|
      t.uuid :user_id, index: true

      t.string :twitter
      t.string :homepage

      t.string :first_name
      t.string :last_name

      t.string :interests, array: true

      t.text :bio

      t.text :address
      t.text :formatted_address
      t.string :city
      t.string :state_province
      t.string :country

      t.float :latitude
      t.float :longitude

      t.timestamps
    end

    add_index :profiles, %i(latitude longitude)
    add_index :profiles, :created_at
  end
end
