class AddPreferredNameToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :preferred_name, :string
  end
end
