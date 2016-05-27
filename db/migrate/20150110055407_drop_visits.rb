# frozen_string_literal: true
class DropVisits < ActiveRecord::Migration
  def change
    drop_table :visits
  end
end
