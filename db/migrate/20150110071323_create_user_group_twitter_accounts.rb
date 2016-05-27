# frozen_string_literal: true
class CreateUserGroupTwitterAccounts < ActiveRecord::Migration
  def change
    create_table :user_group_twitter_accounts do |t|
      t.uuid :user_group_id
      t.integer :twitter_account_id

      t.timestamps
    end
  end
end
