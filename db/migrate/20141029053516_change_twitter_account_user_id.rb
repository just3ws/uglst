class ChangeTwitterAccountUserId < ActiveRecord::Migration
  def change
    change_column :twitter_accounts, :user_id, :integer, limit: 8
  end
end
