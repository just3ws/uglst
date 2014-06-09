class CreateFriendlyIdSlugs < ActiveRecord::Migration
  def change
    create_table :friendly_id_slugs do |t|

      t.datetime :created_at
      t.integer  :sluggable_id,   :null => false
      t.string   :scope
      t.string   :slug,           :null => false
      t.string   :sluggable_type, :limit => 50

    end
    add_index :friendly_id_slugs, :sluggable_id
    add_index :friendly_id_slugs, [:slug, :sluggable_type]
    add_index :friendly_id_slugs, [:slug, :sluggable_type, :scope], :unique => true
    add_index :friendly_id_slugs, :sluggable_type
  end
end
