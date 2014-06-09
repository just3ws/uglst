class CreateUserGroups < ActiveRecord::Migration
  def change
    create_table :user_groups, id: :uuid do |t|

      t.string :city
      t.string :country
      t.string :description
      t.string :homepage
      t.string :latitude
      t.string :longitude
      t.string :name
      t.string :slug
      t.string :state_province
      t.string :topics, array: true
      t.string :twitter
      t.uuid :registered_by_id, index: true

      t.timestamps
    end
  end
end
