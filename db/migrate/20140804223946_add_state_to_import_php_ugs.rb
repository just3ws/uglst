# frozen_string_literal: true
class AddStateToImportPhpUgs < ActiveRecord::Migration
  def change
    add_column :import_php_ugs, :state, :integer, default: 0
  end
end
