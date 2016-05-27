# frozen_string_literal: true
class CreateOpportunities < ActiveRecord::Migration
  def change
    create_table :opportunities, id: :uuid do |t|
      t.string :name
      t.text :description

      t.integer :state, default: 0, null: false

      t.timestamps null: false
    end
  end
end
