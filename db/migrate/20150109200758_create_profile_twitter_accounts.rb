# frozen_string_literal: true
class CreateProfileTwitterAccounts < ActiveRecord::Migration
  def change
    create_table :profile_twitter_accounts do |t|
      t.integer :twitter_account_id
      t.uuid :profile_id

      t.timestamps
    end

    add_index :profile_twitter_accounts, :profile_id
    add_index :profile_twitter_accounts, :twitter_account_id
    # NOTE: Max length of an index name is 64 characters
    add_index :profile_twitter_accounts, %i(profile_id twitter_account_id), name: 'index_profile_twitter_accounts_profile_and_twitter_account'
  end
end
