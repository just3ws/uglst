class CreateSources < ActiveRecord::Migration
  def change
    create_table(:sources, id: :uuid) do |t|
      t.string :name
      t.text :description
      t.string :homepage
      t.string :twitter
      t.string :slug

      t.timestamps
    end
    add_index :sources, :name
    add_index :sources, :slug
  end
end
