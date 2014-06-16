class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.string :name
      t.boolean :enabled
      t.text :description
      t.integer :rules, null: false, default: 0
      t.boolean :enabled, default: false
      t.boolean :production, default: false

      t.timestamps
    end
    add_index :features, :name, unique: true
  end
end
