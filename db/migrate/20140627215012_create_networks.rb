class CreateNetworks < ActiveRecord::Migration
  def change
    create_table(:networks , id: :uuid) do |t|

      t.uuid :registered_by_id, index: true

      t.string :homepage
      t.text :name
      t.string :slug
      t.string :twitter
      t.text :description

      t.string :logo

      t.timestamps
    end
    add_index :networks, :name
  end
end
