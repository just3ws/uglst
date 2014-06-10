class CreateUserGroups < ActiveRecord::Migration
  def change
    create_table :user_groups, id: :uuid do |t|

      t.uuid :registered_by_id, index: true

      t.string :homepage
      t.string :name
      t.string :slug
      t.string :twitter
      t.text :description
      t.text :topics, array: true

      t.text :address
      t.text :formatted_address
      t.string :city
      t.string :state_province
      t.string :country

      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
