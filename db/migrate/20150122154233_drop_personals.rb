class DropPersonals < ActiveRecord::Migration
  def change
    drop_table :personals
  end
end
