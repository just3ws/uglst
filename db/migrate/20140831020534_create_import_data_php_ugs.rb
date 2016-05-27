# frozen_string_literal: true
class CreateImportDataPhpUgs < ActiveRecord::Migration
  def change
    create_table :import_data_php_ugs, id: false do |t|
      t.primary_key :id
      t.json :data
      t.string :state

      t.timestamps
    end
  end
end
