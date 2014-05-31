class CreateUserGroups < ActiveRecord::Migration
  def change
    create_table :user_groups do |t|
      t.string :name
      t.string :city
      t.string :state_province
      t.string :country
      t.string :latitude
      t.string :longitude
      t.string :slug
      t.string :homepage
      t.string :twitter
      t.string :description
      t.integer :registered_by_id
      t.text :topics

      t.timestamps
    end

    add_index :user_groups, :registered_by_id
  end
end
