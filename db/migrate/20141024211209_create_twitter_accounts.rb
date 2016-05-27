# frozen_string_literal: true
class CreateTwitterAccounts < ActiveRecord::Migration
  def change
    create_table :twitter_accounts do |t|
      t.integer :user_id
      t.string :screen_name
      t.json :data

      t.timestamps
    end

    add_index :twitter_accounts, :screen_name, unique: true
    add_index :twitter_accounts, :user_id, unique: true
  end
end
