# frozen_string_literal: true
class CreateImportPhpUgs < ActiveRecord::Migration
  def change
    create_table :import_php_ugs do |t|
      t.integer :php_ug_id
      t.json :php_ug_data

      t.timestamps
    end
  end
end
